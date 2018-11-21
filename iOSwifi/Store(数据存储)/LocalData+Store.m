//
//  LocalData+Store.m
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "LocalData+Store.h"

@implementation LocalData (Store)


//Store
+ (void)saveStore:(NSString *)storeStr {
    [self setObject:storeStr forKey:@"storeStr"];
};

+ (NSString *)getStore {
    return  [self objectForKey:@"storeStr"];
};

/**
 *  App的环境(生产、测试)
 *
 *  @param appEnvi
 */
+ (void)saveAppEnvi:(BOOL)appEnvi {
    
    [self setObject:@(appEnvi) forKey:@"appEnvi"];
};

+ (BOOL)appEnvi {
    
    BOOL appEnvi = [self boolForKey:@"appEnvi"];
    return appEnvi;
};


#pragma mark - 调试模式
//保存调试模式状态

+ (void)saveDebugModeStatus:(BOOL)isOpen
{
    [self setObject:@(isOpen) forKey:@"stone_001"];
}

+ (BOOL)isOpenDebugMode
{
    return [[self objectForKey:@"stone_001"] boolValue];
}

+ (void)saveEnterForegroundVC:(UIViewController *)vcStr {
    [self setObject:NSStringFromClass([vcStr class]) forKey:@"foregroundVC"];
};

+ (UIViewController *)foregroundVC {
    return [[NSClassFromString([self objectForKey:@"foregroundVC"]) alloc] init];
};

+ (void)saveEnterBackgroundTime {
    [self setObject:@([[NSDate date] timeIntervalSince1970]) forKey:@"enterBackgroundTime"];
};

+ (BOOL)isEnterBackgroundTime {
    NSInteger lastTime = [self integerForKey:@"enterBackgroundTime"];
    if (lastTime > 0) {
        return ([[NSDate date] timeIntervalSince1970] - lastTime) > 0;
    }else {
        return NO;
    }
};


@end
