//
//  LocationHelper.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "LocationHelper.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "PermissionHelper.h"

//#import "Constant.h"
//#import "AppDelegate.h"
//#import "WBNotificationHelper.h"
//#import "NSError+WBConvenience.h"

#import "LocalData+Location.h"

NSString *const STLocationHelpDidChangeAuthorizationStatussNotication  = @"STLocationHelpDidChangeAuthorizationStatussNotication";

#define LocationTimeoutInterval     10

@interface LocationHelper ()<BMKGeoCodeSearchDelegate>

@property(nonatomic, assign) BOOL isStopLocation;
@property(nonatomic, assign) NSInteger locationCount;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) NSTimer *timeoutTimer;

@end

@implementation LocationHelper

+ (LocationHelper *) sharedInstance
{
    static LocationHelper *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[LocationHelper alloc] init];
        instance.locationCount = 0;
        instance.hasUpdated = NO;
        instance.updateLocationsBlock = nil;
    });
    return instance;
}

- (void)startLocationWithBlock:(UpdateLocationsBlock)block {
    self.updateLocationsBlock = block;
    self.hasUpdated = NO;
    if ([PermissionHelper isLocationServiceEnabled]) {
        @try {
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
            self.isStopLocation = NO;
            [self.timeoutTimer invalidate];
            self.timeoutTimer = nil;
            self.timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:LocationTimeoutInterval target:self selector:@selector(didUpdateLocationsTimeOut) userInfo:nil repeats:NO];
        } @catch (NSException *exception) {
            [self notifiLocationUpdateFailure:[NSError errorWithDomain:exception.name code:-100 userInfo:exception.userInfo]];
        } @finally {
        }
    }else{
        if (self.updateLocationsBlock) {
            self.updateLocationsBlock(nil,[NSError errorWithDomain:@"Stone.iOSwifi" code:-100 userInfo:@{NSLocalizedDescriptionKey:@"未开启定位服务"}]);
        }
    }
}

- (void)stopLocation {
    if([PermissionHelper isLocationServiceEnabled]) {
        [self.locationManager stopUpdatingLocation];
    }
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //将精确度高(值越低)的排在前面
    locations = [locations sortedArrayUsingComparator:^NSComparisonResult(CLLocation *obj1, CLLocation *obj2) {
        CLLocationAccuracy obj1Accuracy = fabs(obj1.horizontalAccuracy) +  fabs(obj1.verticalAccuracy);
        CLLocationAccuracy obj2Accuracy = fabs(obj2.horizontalAccuracy) +  fabs(obj2.verticalAccuracy);
        if (obj1Accuracy > obj2Accuracy) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
        
        return NSOrderedSame;
    }];
    
    CLLocation *newLocation = [locations firstObject];
    CLLocation *oldLocation = [[CLLocation alloc] initWithLatitude:[LocalData getAppleLatitude] longitude:[LocalData getAppleLongitude]];
    NSDate *lastUpdateLocationsDate = [LocalData getLocationDate];
    
    //精确度大于200的过滤掉
    if ((fabs(newLocation.horizontalAccuracy) >= 200 || fabs(newLocation.verticalAccuracy) >= 200)
        && oldLocation.coordinate.latitude != 0  && oldLocation.coordinate.longitude != 0 && lastUpdateLocationsDate)
    {
        if([LocalData isAvaibleLocation]){//判断经纬度的获取时间是否在5分钟以内
            [self notifiLocationUpdateSuccess:newLocation];
            
            [manager stopUpdatingLocation];
            self.isStopLocation = YES;
            [self cancelTimeoutTimer];
            return;
        }
    }
    
    //使用了百度地图API未公开的方法进行转换
    //详情可见查看我创建的Gist: https://gist.github.com/4155096
    CLLocationCoordinate2D shiftNewLocation = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(newLocation.coordinate, BMK_COORDTYPE_GPS));
    [LocalData saveBDLatitude:shiftNewLocation.latitude];
    [LocalData saveBDLongitude:shiftNewLocation.longitude];
    
    [LocalData saveAppleLatitude:newLocation.coordinate.latitude];
    [LocalData saveAppleLongitude:newLocation.coordinate.longitude];
    
    [LocalData saveLocationDate];
    [self notifiLocationUpdateSuccess:newLocation];
    [LocalData saveLocationTime];
    
    //用户默认语言
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-CN",@"zh-Hans-CN", nil] forKey:@"AppleLanguages"];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array,NSError *error){
        if (array.count > 0)
        {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if ([@"CN" isEqual:placemark.ISOcountryCode]) {
                [LocalData saveGpsProvince:placemark.administrativeArea];
                [LocalData saveGpsCity:placemark.locality];
            }
            
            if (_useForProvinceQQGroups) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PROVINCE_NOTI" object:placemark.administrativeArea];
            }
            //设置回默认语言
            [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
        }
    }];
    
    [manager stopUpdatingLocation];
    self.isStopLocation = YES;
    [self cancelTimeoutTimer];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.isStopLocation) {
        return;
    }
    [manager stopUpdatingLocation];
    self.isStopLocation = YES;
    
    [self notifiLocationUpdateFailure:error];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            [self.locationManager startUpdatingLocation];
            break;
            
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:STLocationHelpDidChangeAuthorizationStatussNotication object:nil];
}

#pragma mark - 定位结束处理
- (void)didUpdateLocationsTimeOut {
    [self.locationManager stopUpdatingLocation];
    self.isStopLocation = YES;
    
    [self cancelTimeoutTimer];
    [self notifiLocationUpdateFailure:[NSError errorWithDomain:@"Stone.iOSwifi" code:-100 userInfo:@{NSLocalizedDescriptionKey:@"定位服务请求超时"}]];
}

- (void)cancelTimeoutTimer {
    if (self.timeoutTimer) {
        if ([self.timeoutTimer isValid]) {
            [self.timeoutTimer invalidate];
        }
    }
}

#pragma mark - 定位结果回调通知
- (void)notifiLocationUpdateSuccess:(CLLocation *)appleLocation {
    if (!self.hasUpdated) {
        self.hasUpdated = YES;
        if (self.updateLocationsBlock) {
            self.updateLocationsBlock(appleLocation, nil);
        }
    }
}

- (void)notifiLocationUpdateFailure:(NSError *)error  {
    if (!self.hasUpdated) {
        self.hasUpdated = YES;
        if (self.updateLocationsBlock) {
            if ([CLLocationManager authorizationStatus] < 3) {
                self.updateLocationsBlock(nil, [NSError errorWithDomain:@"Stone.iOSwifi" code:-100 userInfo:@{NSLocalizedDescriptionKey:@"未授权允许定位服务"}]);
            }else {
                self.updateLocationsBlock(nil, error);
            }
        }
    }
}

#pragma mark - lazy load
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setDistanceFilter:50.0f];
    }
    return _locationManager;
}

#pragma mark - public class method
+ (void)relocationIfNeed {
    if ([LocalData isLocationTime]) {
        [[LocationHelper sharedInstance] startLocationWithBlock:nil];
    }
}

@end

