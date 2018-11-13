//
//  NSTimer+Pluto.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Pluto)

/**
 *  创建一个不会造成循环引用的循环执行的Timer
 */
+ (instancetype)stScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo;

@end

NS_ASSUME_NONNULL_END
