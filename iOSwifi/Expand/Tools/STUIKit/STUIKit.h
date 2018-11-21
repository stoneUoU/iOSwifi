//
//  STUIKit.h
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STUIKit : NSObject

/**
 *  标准色 白色
 *  重要 0xffffff    RGB 255 255 255
 *  @return UIColor
 */
+ (UIColor *)colorC00;

/**
 *  标准色 黑色
 *  重要 0x000000    RGB 0 0 0
 *  @return UIColor
 */
+ (UIColor *)colorC01;

/**
 *  标准色 深灰色
 *  辅助 0x555555    RGB 85 85 85
 *  ...
 *  @return UIColor
 */
+ (UIColor *)colorC15;

+ (UIColor *)colorC16;

+ (UIColor *)colorC17;

/**
 *  标准字  18pt
 *  用于少数重要标题
 *  如导航标题、弹窗Title
 *  @return UIFont
 */
+ (UIFont *)fontF00;

/**
 *  标准字  17pt
 *  用于少数重要标题
 *  如导航标题、弹窗Title
 *  @return UIFont
 */
+ (UIFont *)fontF017;

/**
 *  标准字    16pt
 *  用于大多数文字、按钮
 *  如list文字、文字按钮、btn文字等
 *  @return UIFont
 */
+ (UIFont *)fontF02;

@end

NS_ASSUME_NONNULL_END
