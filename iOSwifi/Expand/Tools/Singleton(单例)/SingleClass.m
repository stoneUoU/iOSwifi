//
//  SingleClass.m
//  iOSwifi
//
//  Created by Stone on 2018/11/11.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "SingleClass.h"
//单例模式
@implementation SingleClass

static SingleClass *_shareIns = nil;

+(id)shareIns{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareIns = [[super allocWithZone:NULL] init];
    });
    return _shareIns;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    return [SingleClass shareIns];
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return [SingleClass shareIns];
}

@end
