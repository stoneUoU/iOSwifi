//
//  BaseViewController.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPlaceholderView.h"

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate,STPlaceholderViewDelegate>

/****状态栏****/
@property (nonatomic ,strong)UIView *statusV;

/****导航栏****/
@property (nonatomic ,strong)UIView *navBarV;

/****标题****/
@property (nonatomic ,strong)UILabel *midFontL;

/****返回按钮****/
@property (nonatomic ,strong)UIButton *backBtn;

/****右边按钮****/
@property (nonatomic ,strong)UIButton *sideBtn;

/****用户唯一标识****/
@property(nonatomic, copy) NSString *authos;

//定义一个没有数据时的View
@property (nonatomic,strong)STPlaceholderView *placeholderV;

//创建导航栏
- (void)setBaseUI:(NSString *) midVal sideVal:(NSString *)sideVal backIvName:(NSString *)backIvName navC:(UIColor *)navC midFontC:(UIColor *)midFontC sideFontC:(UIColor *)sideFontC;

//定义方法
- (void)toBack;

//定义方法
- (void)toSide;

@end

