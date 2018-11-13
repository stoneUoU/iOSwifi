//
//  NetworkChangeSingleton.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CurrentNetworkStatus) {
    CurrentNetworkStatusNetworkOffline,         //网络不可用
    CurrentNetworkStatusCellularNetwork,        //数据流量
    CurrentNetworkStatusWiFiUnavailable,        //WiFi不可用ß
};

@interface NetworkChangeSingleton : NSObject

/**
 当前网络状态
 */
@property (nonatomic, assign) CurrentNetworkStatus status;

/**
 单例创建
 */
+ (instancetype)sharedInstance;

//Don't use.
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

