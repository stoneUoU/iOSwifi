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

+(UIFont *)fontF00
{
    return [UIFont systemFontOfSize:18];
}

@end
