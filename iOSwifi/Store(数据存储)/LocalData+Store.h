//
//  LocalData+Store.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "LocalData.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocalData (Store)

//Store
+ (void)saveStore:(NSString *)storeStr;

+ (NSString *)getStore;

/**
 *  App的环境(生产、测试)
 *
 *  @param appEnvi
 */
+ (void)saveAppEnvi:(BOOL)appEnvi;
+ (BOOL)appEnvi;


/**
 *  保存调试模式状态
 */
+ (void)saveDebugModeStatus:(BOOL)isOpen;
+ (BOOL)isOpenDebugMode;

/**
 *  保存进入后台的控制器
 */
+ (void)saveEnterForegroundVC:(UIViewController *)vc;
+ (UIViewController *)foregroundVC;

/**
 *  保存进入后台的时间
 */
+ (void)saveEnterBackgroundTime;
+ (BOOL)isEnterBackgroundTime;

@end

NS_ASSUME_NONNULL_END
