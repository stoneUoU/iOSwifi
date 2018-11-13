//
//  STLogService.m
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "STLogService.h"
#import "STLogFormatter.h"

@implementation STLogService

+ (void)start {
    [self sharedInstance];
}

+ (instancetype)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        STLogFormatter *formatter = [[STLogFormatter alloc] init];
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        
        #if TARGET_OS_IPHONE
            UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
        #else
            UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
        #endif
        [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:DDLogFlagInfo];
        [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:DDLogFlagError];
        [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:DDLogFlagDebug];
        [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:DDLogFlagVerbose];

        [DDLog addLogger:fileLogger];
        [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        
        setenv("XcodeColors", "YES", 0);
        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
        
        //获取log文件夹路径
        NSString *logDirectory = [fileLogger.logFileManager logsDirectory];
        //STLog(@"%@", logDirectory);
    }
    return self;
}

@end
