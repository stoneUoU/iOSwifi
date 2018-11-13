//
//  STLogFormatter.m
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "STLogFormatter.h"

@implementation STLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    
    NSString *logLevel = nil;
    
    switch (logMessage.flag) {
            
        case DDLogFlagDebug:
            logLevel = @"[Debug]  ";
            break;
            
        case DDLogFlagInfo:
            logLevel = @"[Info]  ";
            break;
            
        case DDLogFlagWarning:
            logLevel = @"[Warning]  ";
            break;
            
        case DDLogFlagError:
            logLevel = @"[Error]  ";
            break;
            
        default:
            logLevel = @"[Verbose]  ";
            break;
    }
    
    NSString *formatterString = [NSString stringWithFormat:@"%@%@.m  %@  line  %lu: %@",
                                 logLevel, logMessage.fileName, logMessage.function,
                                 (unsigned long)logMessage.line, logMessage.message];
    return formatterString;
}

@end
