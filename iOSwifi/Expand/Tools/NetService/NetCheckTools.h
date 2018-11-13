//
//  NetCheckTools.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "Reachability.h"

@interface NetCheckTools : AFHTTPSessionManager
/** 设置全局变量的属性. */
@property (nonatomic, assign)BOOL isNetUseful;

+ (instancetype)sharedIns;

+(BOOL) isUsingWiFiConnected;

+ (BOOL)isNetOffLine;

+ (BOOL)isUsingWWAN;

+ (Reachability *)defaultReachability;

+ (NSString *)currentNetworkStatus;

@end

