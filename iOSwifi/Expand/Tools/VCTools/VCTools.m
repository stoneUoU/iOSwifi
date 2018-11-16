//
//  VCTools.m
//  iOSwifi
//
//  Created by Stone on 2018/11/11.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "VCTools.h"
#import "AppDelegate.h"
#import "TabBarViewController.h"

//最大支持的的控制器层数
static const int maxViewControllerStackCount = 1000;

@implementation VCTools

+ (void)presentToCommVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC animate:(BOOL )animateBool{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC presentViewController:destVC animated:animateBool completion:nil];
    });
}


+ (void)presentToNaviVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC animate:(BOOL )animateBool{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC presentViewController:[[UINavigationController alloc] initWithRootViewController:destVC] animated:animateBool completion:nil];
    });
}

+ (void)dismissCurrVC:(UIViewController *)selfVC animate:(BOOL )animateBool{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC dismissViewControllerAnimated:animateBool completion:nil];
    });
}

+ (void)pushToNextVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController pushViewController:destVC animated:YES];
    });
}

+ (void)popToPrevVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController popViewControllerAnimated:YES];
    });
}

+ (void)popToSpecialVC:(UIViewController *)selfVC specialVC:(id )specialVC{
    for(UIViewController *ctrl in selfVC.navigationController.viewControllers) {
        if([ctrl isKindOfClass:specialVC]) {
            [selfVC.navigationController popToViewController:ctrl animated:YES];
        }
    }
}

+ (void)popToRootVC:(UIViewController *)selfVC {
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController popToRootViewControllerAnimated:YES];
    });
}

+ (UIViewController *)getCurrVC {
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+ (UIViewController *)getPresentedVC
{
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)topVC topViewController];
    }
    return topVC;
}

/**
 获取当前控制器(包括普通或者弹出的)
 */
+ (UIViewController *)getFrontViewController {
    UIViewController *result = nil;
    
    UIWindow *window = [self frontWindow];
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    result = nextResponder;
    else
    result = window.rootViewController;
    //present出来的控制器-假设有1000层presen出来的控制器
    for (int i = 0; i < maxViewControllerStackCount; i++) {
        if (result.presentedViewController) {
            result = result.presentedViewController;
        }else{
            break;
        }
    }
    
    return result;
}

+ (UIWindow *)frontWindow {
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        UIWindowLevel maxSupportedWindowLevel =  [UIApplication sharedApplication].keyWindow.windowLevel;//UIWindowLevelStatusBar + 1;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= maxSupportedWindowLevel);
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
            return window;
        }
    }
    return nil;
}

+ (UIViewController *)getTarBarSelectVC{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabVC = (UITabBarController *)delegate.window.rootViewController;
    UIViewController *selectVC =  tabVC.selectedViewController;
    return selectVC;
}


@end
