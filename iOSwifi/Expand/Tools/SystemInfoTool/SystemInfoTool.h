//
//  SystemInfoTool.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SystemInfoTool : NSObject

//空闲CPU（单位：%）
+ (CGFloat)cpuFree;

//空闲CPU所占比例（单位：%）
+ (CGFloat)cpuUsagePercent;

//空闲内存（单位：M）
+ (CGFloat)memoryFree;

//内存总量（单位：M）
+ (CGFloat)memoryTotal;

//空闲内存所占比例（单位：M）
+ (CGFloat)memoryUsagePercent;

//空闲容量（单位：M）
+ (CGFloat)diskFree;

//所有容量（单位：G）
+ (CGFloat)diskTotal;

//空闲容量所占比例（单位：%）
+ (CGFloat)diskUsagePercent;

//获取手机型号
+ (NSString *)deviceModel;

@end

NS_ASSUME_NONNULL_END
