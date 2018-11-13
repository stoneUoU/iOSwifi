//
//  STLogService.h
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

// 默认的宏，方便使用
#define STLog(frmt, ...)           DDLogInfo(frmt, ##__VA_ARGS__)

// 提供不同的宏，对应到特定参数的对外接口
#define STLogError(frmt, ...)      DDLogError(frmt, ##__VA_ARGS__)
#define STLogWarning(frmt, ...)    DDLogWarn(frmt, ##__VA_ARGS__)
#define STLogInfo(frmt, ...)       DDLogInfo(frmt, ##__VA_ARGS__)
#define STLogDebug(frmt, ...)      DDLogDebug(frmt, ##__VA_ARGS__)
#define STLogVerbose(frmt, ...)    DDLogVerbose(frmt, ##__VA_ARGS__)


@interface STLogService : NSObject

+ (void)start;

@end

