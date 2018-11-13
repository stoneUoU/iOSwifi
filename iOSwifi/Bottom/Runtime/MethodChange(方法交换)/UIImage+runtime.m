//
//  UIImage+runtime.m
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "UIImage+runtime.h"
#import <objc/runtime.h>
@implementation UIImage(runtime)

+ (void)load {
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(st_imageNamed:));
    method_exchangeImplementations(m1, m2);
}

+ (UIImage *)st_imageNamed:(NSString *)name {
    return [UIImage st_imageNamed:[NSString stringWithFormat:@"%@",name]];
}

@end

