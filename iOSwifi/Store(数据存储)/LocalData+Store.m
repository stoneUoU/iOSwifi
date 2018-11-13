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



@end
