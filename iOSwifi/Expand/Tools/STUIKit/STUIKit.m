//
//  STUIKit.m
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "STUIKit.h"
#import "UIColor+Hex.h"

@implementation STUIKit

+ (UIColor *)colorC00
{
    return [UIColor color_HexStr:@"#ffffff"];
}

+ (UIColor *)colorC01
{
    return [UIColor color_HexStr:@"#000000"];
}

+ (UIColor *)colorC15
{
    return [UIColor color_HexStr:@"#555555"];
}

+ (UIColor *)colorC16
{
    return [UIColor color_HexStr:@"#007aff"];
}

+ (UIColor *)colorC17
{
    return [UIColor color_HexStr:@"#1e96ff"];
}


+ (UIFont *)fontF00
{
    return [UIFont systemFontOfSize:18];
}

+ (UIFont *)fontF017
{
    return [UIFont systemFontOfSize:17];
}

+ (UIFont *)fontF02
{
    return [UIFont systemFontOfSize:16];
}



@end
