//
//  NSTimerMode.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "NSTimerMode.h"
#import "NSTimer+Pluto.h"
#import "STWeakProxy.h"

@interface NSTimerMode ()

@property(nonatomic,strong) NSTimer *timer;

@end

@implementation NSTimerMode

- (instancetype)init
{
    self = [super init ];//当前对象self
    if (self !=nil) {//如果对象初始化成功，才有必要进行接下来的初始化
//        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(desc:) userInfo:@{@"user_name":@"I am Stone"} repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
//        if (@available(iOS 10.0, *)) {
//            NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//                STLog(@"嘀嗒嘀嗒");
//            }];
//            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//        }else {
//        // Fallback on earlier versions
//        }
        
//        SEL action = @selector(desc:);
//        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:[[self class]   instanceMethodSignatureForSelector:action]];
//        [invo setTarget:self];
//        [invo setSelector:action];
//        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 invocation:invo repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
//        NSInvocation *invo = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(timerDesc:)]];
//        [invo setTarget:self];
//        [invo setSelector:@selector(timerDesc:)];
//        NSString *str = @"invo测试环境";
//        [invo setArgument:&str atIndex:2];
//        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 invocation:invo repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
        //NSTimer *timerStart = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(desc:) userInfo:@{@"user_name":@"I am Stone"} repeats:YES];
        
        
        //异步开启子线程运行相应的代码
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSTimer * timer = [NSTimer timerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
//                static int count = 0;
//                [NSThread sleepForTimeInterval:2];
//                //休息一秒钟，模拟耗时操作
//                STLog(@"===========%d",count++);
//            }];
//            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//            [[NSRunLoop currentRunLoop] run];
//        });
        
//        NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(longrun) object:nil];
//        [thread start];
//        if (@available(iOS 10.0, *)) {
//            [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//                [self performSelector:@selector(runmethod) onThread:thread withObject:nil waitUntilDone:YES modes:@[NSDefaultRunLoopMode]];
//            }];
//        } else {
//            // Fallback on earlier versions
//        }
        
        [NSTimer stScheduledTimerWithTimeInterval:1.0 target:self selector:@selector(desc:) userInfo:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:[STWeakProxy proxyWithTarget:self] selector:@selector(desc:) userInfo:nil repeats:YES];
    }
    return self;//返回一个已经初始化完毕的对象；
}

- (void)longrun {
    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
    //为了防止runloop退出，添加一个端口。
    [runLoop addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
    [runLoop runUntilDate:[NSDate distantFuture]];
}

- (void)runmethod
{
    STLog(@"%@ 辅助线程上执行的代码",[NSThread currentThread]);
}

- (void)timerDesc:(NSString *)str {
    STLog(@"++倒计时走起来++++++++++++%@",str);
}

- (void)desc:(NSTimer *)timer {
    STLog(@"++倒计时走起来++++++++++++%@",[[timer userInfo] objectForKey:@"user_name"]);
}

@end
