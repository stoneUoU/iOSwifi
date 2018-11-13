//
//  PermissionHelper.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "PermissionHelper.h"
#import <Photos/Photos.h>

@implementation PermissionHelper

/**
 *  是否允许通知
 *
 *  @return bool
 */
+ (BOOL)isAllowedNotification {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        return YES;
    }
    
    return NO;
}

/**
 *  判断是否允许访问相册
 *
 *  @return bool
 */
+ (BOOL)isAllowedAccessPhotoLibrary {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    return status == PHAuthorizationStatusAuthorized;
}

/**
 *  判断网络是否可以访问
 *
 *  @return bool
 */
+ (BOOL)isNetworkAvailable {
    return [NetCheckTools sharedIns].isNetUseful;
}

/**
 *  判断定位是否可用
 *
 *  @return bool
 */
+ (BOOL)isLocationAvailable {
    return [self isLocationAuthStatusEnabled] && [self isLocationServiceEnabled];
}

+ (BOOL)isLocationAuthStatusEnabled {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return (status == kCLAuthorizationStatusAuthorizedAlways
            || status == kCLAuthorizationStatusAuthorizedWhenInUse);
    
}

+ (BOOL)isLocationServiceEnabled {
    return [CLLocationManager locationServicesEnabled];
}


/**
 *  可否打开地址
 *
 *  @param urlStr 地址
 *
 *  @return bool
 */
+ (BOOL)canOpenPrivateUrl:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    if (iOS10) {
        return YES;
    }else {
        return [[UIApplication sharedApplication] canOpenURL:url];
    }
}

/**
 *  打开地址, 支持pr和scheme(无白名单)
 *
 *  @param urlStr 地址String
 */
+ (BOOL)openUrl:(NSString *)urlStr {
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

+ (void)gotoPermission {
    if (![PermissionHelper isAllowedNotification]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}


@end
