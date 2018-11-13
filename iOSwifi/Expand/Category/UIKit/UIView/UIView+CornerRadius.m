//
//  UIView+CornerRadius.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)

- (void)makeCornerRadius
{
    [self createCornerRadiusWithRadius:5 rectCorner:UIRectCornerAllCorners];
}

- (void)makeCornerRadiusWithRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner
{
    [self createCornerRadiusWithRadius:radius rectCorner:rectCorner];
}

- (void)createCornerRadiusWithRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner
{
    if (![self isKindOfClass:[UIImageView class]]){
        UIBezierPath *maskPath  = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                        byRoundingCorners:rectCorner
                                                              cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame         = self.bounds;
        maskLayer.path          = maskPath.CGPath;
        self.layer.mask         = maskLayer;
    }
}

@end
