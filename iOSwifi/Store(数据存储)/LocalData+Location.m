//
//  LocalData+Location.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "LocalData+Location.h"

static NSString *const GPSProvince  = @"GPS00000_001";
static NSString *const GPSCity  = @"GPS00000_002";

#define LocationDate   @"location_date"
#define CONST_LAT  @"const_lat"
#define CONST_LNG  @"const_lng"

#define CONST_LAT_ORI  @"ori_const_lat"
#define CONST_LNG_ORI  @"ori_const_lng"


@implementation LocalData (Location)

//Gps定位城市
+(void)saveGpsCity:(NSString *)city {
    [self setObject:city forKey:GPSCity];
}

+ (NSString *)getGpsCity {
    NSString *city = [self objectForKey:GPSCity];
    return city.length ? city : @"厦门市";
}

//3、GPS定位省份
+(void)saveGpsProvince:(NSString *)province {
    [self setObject:province forKey:GPSProvince];
}

//4、获取GPS定位省份
+(NSString *) getGpsProvince {
    NSString *value = [self objectForKey:GPSProvince];
    return value.length > 0 ? value : @"未知省份";
}

+ (void)saveBDLatitude:(double)lat {
    [self setObject:@(lat) forKey:CONST_LAT];
}

+ (double)getBDLatitude {
    return [self doubleForKey:CONST_LAT];
}

+ (void)saveBDLongitude:(double)lng {
    [self setObject:@(lng) forKey:CONST_LNG];
}

+ (double)getBDLongitude {
    return [self doubleForKey:CONST_LNG];
}

+ (void)saveAppleLatitude:(double)lat {
    [self setObject:@(lat) forKey:CONST_LAT_ORI];
}

+ (double)getAppleLatitude {
    return [self doubleForKey:CONST_LAT_ORI];
}

+ (void)saveAppleLongitude:(double)lng {
    [self setObject:@(lng) forKey:CONST_LNG_ORI];
}

+ (double)getAppleLongitude {
    return [self doubleForKey:CONST_LNG_ORI];
}

+ (void)saveLocationDate{
    [self setObject:[NSDate date] forKey:LocationDate];
}

+ (NSDate *)getLocationDate {
    return [self objectForKey:LocationDate];
}

+ (BOOL)isAvaibleLocation {
    return (fabs([[NSDate date] timeIntervalSinceDate:[self getLocationDate]]) <= 5 * 60);
}

+ (double)getDefaultLatitude {
    return 24.50;
}

+ (double)getDefaultLongitude {
    return 118.15;
}

//判断是否满足需要定位时间
+ (BOOL)isLocationTime {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSInteger tmp = [settings integerForKey:@"LastLocationTime"];
    if (tmp > 0) {
        return ([[NSDate date] timeIntervalSince1970] - tmp) > 5 * 60;
    }else {
        return NO;
    }
}

//保存定位时间
+ (void)saveLocationTime {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"LastLocationTime"];
    [settings setInteger:[[NSDate date] timeIntervalSince1970] forKey:@"LastLocationTime"];
    [settings synchronize];
}


@end
