//
//  STPlaceholderView.m
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "STPlaceholderView.h"

@implementation STPlaceholderView

#pragma mark - 构造方法
/**
 构造方法

 @param frame 占位图的frame
 @param type 占位图的类型
 @param delegate 占位图的代理方
 @return 指定frame、类型和代理方的占位图
 */
- (instancetype)initWithFrame:(CGRect)frame type:(STPlaceholderViewType)type delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        // 存值
        _type = type;
        _delegate = delegate;
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [UIColor clearColor];

    //------- 图片在正中间 -------//
    //UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-200)/2, ScreenH / 2 - 100 - StatusBarAndNaviBarH, 200, 133)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-200)/2, (self.frame.size.height - 200*StScaleH)/2- 50*StScaleH, 200, 133)];
    [self addSubview:imageView];

    //------- 说明label在图片下方 -------//
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 30*StScaleH, self.frame.size.width, 20*StScaleH)];
    [self addSubview:descLabel];
    descLabel.textAlignment = NSTextAlignmentCenter;

    //------- 按钮在说明label下方 -------//
    UIButton *reloadButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 60*StScaleW, CGRectGetMaxY(descLabel.frame) + 50*StScaleH, 120*StScaleW, 40*StScaleH)];
    [self addSubview:reloadButton];
    [reloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reloadButton.layer.borderColor = [UIColor blackColor].CGColor;
    reloadButton.layer.borderWidth = 1;
    reloadButton.layer.cornerRadius = 3;
    reloadButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    //------- 根据type创建不同样式的UI -------//
    switch (_type) {
        case STPlaceholderViewTypeNoNetwork: // 没网
        {
            imageView.image = [UIImage imageNamed:@"noNet"];
            descLabel.text = @"没有网络，请检查网络设置";
            [reloadButton setTitle:@"点击重试" forState:UIControlStateNormal];
        }
            break;
        case STPlaceholderViewTypeNoPosi: /** 没有位置权限 */
        {
            imageView.image = [UIImage imageNamed:@"noPosi"];
            descLabel.text = @"没有位置信息，点击获取定位";
            [reloadButton setTitle:@"获取定位" forState:UIControlStateNormal];
        }
            break;
        case STPlaceholderViewTypeNoStore: /** 没有门店信息 */
        {
            imageView.image = [UIImage imageNamed:@"noData"];
            descLabel.text = @"没有门店，点击刷新试试";
            [reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
        }
            break;
        case STPlaceholderViewTypeNoOrder: /** 没有订单信息 */
        {
            imageView.image = [UIImage imageNamed:@"noData"];
            descLabel.text = @"没有订单，点击刷新试试";
            [reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
        }
            break;
        case STPlaceholderViewTypeNoShopCart: /** 没有购物车信息 */
        {
            imageView.image = [UIImage imageNamed:@"noShopCart"];
            descLabel.text = @"没有数据，点击刷新试试";
            [reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
        }
            break;

        default:
            break;
    }
}

#pragma mark - 重新加载按钮点击
/** 重新加载按钮点击 */
- (void)reloadButtonClicked:(UIButton *)sender{
    // 代理方执行方法
    if ([_delegate respondsToSelector:@selector(placeholderView:reloadButtonDidClick:)]) {
        [_delegate placeholderView:self reloadButtonDidClick:sender];
    }
}

@end
