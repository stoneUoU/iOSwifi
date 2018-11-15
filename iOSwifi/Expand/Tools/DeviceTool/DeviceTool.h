//
//  DeviceTool.h
//  iOSwifi
//
//  Created by Stone on 2018/11/15.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTCarrier.h>

@interface DeviceTool : NSObject

///获取设备IDFV
+ (NSString *)deviceIdfv;

//获取设备IDFA
+ (NSString *)deviceIdfa;

//default idfa
+ (NSString *)originIdfa;

//for wssp
+ (NSString *)getUnchangedOriginIdfa;

/**
 获取电话运营商名称
 */
+ (NSString*)getCarrierName;

/**
 获取电话网络类型
 */
+ (NSString *)getTelephonyNetworkType;

/**
 是否设备中有SIM卡
 */
+ (BOOL)hasSIMCard;

/**
 获取设备版本
 */
+ (NSString *)getDeviceVersion;

/**
 设备型号
 */
+ (NSString *)platformString;

/**
 当前设备语言
 */
+ (NSString *)getCurrentLanguage;

/**
 当前区域
 */
+ (NSString *)getCurrentRegion;

/**
 当前运营商信息
 */
+ (CTCarrier *)getCurrentCarrier;

/**
 当前设备存储大小
 */
+ (NSString *)getDeviceDiskSize;

/**
 *  淘宝接口获取外网ip信息
 *  @return ip详情
 */
+ (NSDictionary *)ipInfo;

/**
 *  淘宝接口获取外网ip地址
 *  @return ip地址
 */
+ (NSString *)deviceWANIPAddress;

/**
 *  高德地图api获取ip定位
 *  @return 定位信息json
 */
+ (NSDictionary *)ipLocationInfo;

/**
 *  高德地图获取ip定位地址
 *  @return 省份+城市
 */
+ (NSString *)ipLocation;

/**
 当前设备Mac
 */
+ (NSString *) getMacaddress;

@end
