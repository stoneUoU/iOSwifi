//
//  LocalData+Location.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "LocalData.h"

@interface LocalData (Location)

//GPS定位城市
+ (void)saveGpsCity:(NSString *)city;
+ (NSString *)getGpsCity;

//GPS定位省份
+ (void) saveGpsProvince:(NSString *)province;
+ (NSString *)getGpsProvince;

//百度纬度
+ (void)saveBDLatitude:(double)lat;
+ (double)getBDLatitude;

//百度经度
+ (void)saveBDLongitude:(double)lng;
+ (double)getBDLongitude;

//ios纬度
+ (void)saveAppleLatitude:(double)lat;
+ (double)getAppleLatitude;

//ios经度
+ (void)saveAppleLongitude:(double)lng;
+ (double)getAppleLongitude;

//获取定位时间
+ (void)saveLocationDate;
+ (NSDate *)getLocationDate;

+ (BOOL)isAvaibleLocation;

+ (double)getDefaultLatitude;
+ (double)getDefaultLongitude;

//判断是否满足需要定位时间
+ (BOOL)isLocationTime;

//保存定位时间
+ (void)saveLocationTime;

@end
