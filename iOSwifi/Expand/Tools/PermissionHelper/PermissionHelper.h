//
//  PermissionHelper.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PermissionHelper : NSObject

+ (BOOL)isNetworkAvailable;

+ (BOOL)isAllowedAccessPhotoLibrary;

+ (BOOL)isAllowedNotification;

+ (BOOL)isLocationAvailable;

+ (BOOL)isLocationAuthStatusEnabled;

+ (BOOL)isLocationServiceEnabled;

+ (BOOL)canOpenPrivateUrl:(NSString *)urlStr;

+ (BOOL)openUrl:(NSString *)urlStr;

+ (void)gotoPermission;


@end
