//
//  NSDate+Extension.m
//  iOSwifi
//
//  Created by Stone on 2018/11/15.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSString *)timeToStr
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 60 * 60];
    });
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [dateFormatter setCalendar:calendar];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    if (self == nil) {
        return @"";
    }
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [currentCalendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *currentDateComponent = [currentCalendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    if (dateComponent.year == currentDateComponent.year) {
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    NSString *timeDescription = nil;
    float timeValue = timeInterval/60;
    if (timeValue < 1) {
        timeDescription = @"刚刚";
        return timeDescription;
    }
    if(timeValue >= 1 && timeValue < 60){
        timeDescription = [NSString stringWithFormat:@"%d分钟前",(int)timeValue];
        return timeDescription;
    }
    timeValue = timeValue/60;
    
    if ( timeValue >= 1 && timeValue < 24) {
        timeDescription = [NSString stringWithFormat:@"%d小时前 ",(int)timeValue];
        return timeDescription;
    }
    timeValue = timeValue/24;
    if (timeValue >= 1 && timeValue < 2) {
        timeDescription = [NSString stringWithFormat:@"昨天"];
        return timeDescription;
    }
    else if (timeValue >= 2 && timeValue < 3){
        timeDescription = [NSString stringWithFormat:@"前天"];
        return timeDescription;
    }else if (timeValue < 7){
        timeDescription = [NSString stringWithFormat:@"%d天前",(int)timeValue];
        return timeDescription;
    }else{
        timeDescription = [dateFormatter stringFromDate:self];
    }
    
    return timeDescription;
}

@end
