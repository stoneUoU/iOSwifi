//
//  UIView+CornerRadius.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerRadius)

- (void)makeCornerRadius;

- (void)makeCornerRadiusWithRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner;

@end

NS_ASSUME_NONNULL_END
