//
//  VCTools.m
//  iOSwifi
//
//  Created by Stone on 2018/11/11.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "VCTools.h"

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
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

@end
