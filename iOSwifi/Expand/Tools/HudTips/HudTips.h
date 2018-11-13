//
//  HudTips.h
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HudTips : NSObject
//显示
+ (void)showHUD:(UIViewController *)ctrl;
//隐藏
+ (void)hideHUD:(UIViewController *)ctrl;

//此处写的是上面StToaster的代码
+ (void)showToast:(NSString *)text showType:(StToastShowType)type animationType:(StToastAnimationType)animationType;

@end
