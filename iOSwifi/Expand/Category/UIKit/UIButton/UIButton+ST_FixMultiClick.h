//
//  UIButton+ST_FixMultiClick.h
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ST_FixMultiClick)

@property (nonatomic, assign) NSTimeInterval st_acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) NSTimeInterval st_acceptEventTime;

- (void)fitSizeToBtn:(CGSize)size;   //调整按钮点击范围

@end

NS_ASSUME_NONNULL_END
