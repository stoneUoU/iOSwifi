//
//  UIFont+runtime.m
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "UIFont+runtime.h"
#import <objc/runtime.h>

@implementation UIFont (runtime)

+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(setFontScale:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
}

+ (UIFont *)setFontScale:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont setFontScale:fontSize * ScreenW/iphoneSixW];
    return newFont;
}
@end
