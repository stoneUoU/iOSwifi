//
//  FirstClass.m
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "FirstClass.h"

@implementation FirstClass

+(void)load
{
    //STLog(@"NoneClass _cmd: %@", NSStringFromSelector(_cmd));
}

- (void)firstClassMethod:(NSString *)paras andStr:(NSString *)str
{
    STLog(@"_cmd: %@  =============  携带第一个参数   %@      携带第二个参数  %@", NSStringFromSelector(_cmd),paras,str);
}

@end
