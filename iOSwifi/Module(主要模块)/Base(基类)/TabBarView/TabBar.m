//
//  TabBar.m
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "TabBar.h"
#import <objc/runtime.h>
#import "UIImage+intoColor.h"
#import "UIView+Extension.h"

@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        //加个View去掉tabbarV默认的线
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, -1, ScreenW, 1)];
        lineV.backgroundColor = [UIColor color_HexStr:@"f8f8f8"];
        [self addSubview:lineV];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");

    int btnIndex = 0;
    for (UIButton *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            btn.width = self.width / 3;
            btn.x = btn.width * btnIndex;
            btn.tag = btnIndex;
            btnIndex++;
        }
    }
}
@end
