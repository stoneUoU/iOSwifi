//
//  UIView+Extension.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, STGradientColorDirection) {
    STGradientColorDirectionTopLeftToBottomRight = 1,   //左上到右下
    STGradientColorDirectionTopRightToBottomLeft,       //右上到左下
    STGradientColorDirectionBottomLeftToTopRight,       //左下到右上
    STGradientColorDirectionBottomRightToTopLeft,       //右下到左上
    STGradientColorDirectionLeftToRight,                //左到右
    STGradientColorDirectionTopToBottom,                //上到下
    STGradientColorDirectionBottomToTop,                //下到上
};

IB_DESIGNABLE

@interface UIView (Extension)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)viewController;

/**
 设备view背景渐变色
 
 @param fromColor 起始颜色
 @param toColor 终止颜色
 @param direction 渐变方向
 */
- (void)setBackgroundGradientFromColor:(UIColor *)fromColor
                               toColor:(UIColor *)toColor
                             direction:(STGradientColorDirection)direction;

/**
 获取渐变色背景图层
 
 @param fromColor 起始颜色
 @param toColor 终止颜色
 @param direction 渐变方向
 @return 渐变图层
 */
- (CAGradientLayer *)getGradientLayerFromColor:(UIColor *)fromColor
                                       toColor:(UIColor *)toColor
                                     direction:(STGradientColorDirection)direction;

@end

