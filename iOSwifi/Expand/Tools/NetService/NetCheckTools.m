//
//  NetCheckTools.m
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "NetCheckTools.h"

@implementation NetCheckTools
+ (instancetype)sharedIns {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (Reachability *)defaultReachability
{   static Reachability *r;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //使用注释的方法会导致网络检测异常，注意！！！
        r = [Reachability reachabilityForInternetConnection];
    });
    return r;
}

- (instancetype)init {
    if ((self = [super init])) {
        // 设置超时时间，afn默认是60s
        self.requestSerializer.timeoutInterval = 30;
        // 响应格式添加text/plain
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
        
        // 监听网络状态,每当网络状态发生变化就会调用此block
        __weak typeof(self) weakSelf = self;
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:     // 无连线
                    STLog(@"No NetWork");
                    weakSelf.isNetUseful = NO;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    STLog(@"WWAN");
                    weakSelf.isNetUseful = YES;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi: // WiFi
                    STLog(@"WiFi");
                    weakSelf.isNetUseful = YES;
                    break;
                case AFNetworkReachabilityStatusUnknown:          // 未知网络
                default:
                    STLog(@"Unknown NetWork");
                    weakSelf.isNetUseful = YES;
                    break;
            }
        }];
        // 开始监听
        [self.reachabilityManager startMonitoring];
    }
    return self;
}


+ (BOOL)isUsingWiFiConnected {
    BOOL isWiFi = [[Reachability reachabilityForInternetConnection] isReachableViaWiFi];
    //BOOL getSSID = [[HMWifiInfoHelper sharedInstance] fetchSSID] != nil;
    return isWiFi; //isWiFi && getSSID;
}

+ (BOOL)isNetOffLine {
    return [[self defaultReachability] currentReachabilityStatus] == NotReachable;
}

+ (BOOL)isUsingWWAN {
    return [[self defaultReachability] currentReachabilityStatus] == ReachableViaWWAN;
}

+ (NSString *)currentNetworkStatus {
    NetworkStatus status = [self defaultReachability].currentReachabilityStatus;
    NSString *statusStr = @"移动数据";
    switch (status) {
        case NotReachable:
            statusStr = @"无网络";
            break;
        case ReachableViaWWAN:
            statusStr = @"移动数据";
            break;
        case ReachableViaWiFi:
            statusStr = @"WiFi";
            break;
        default:
            break;
    }
    return statusStr;
}
@end
