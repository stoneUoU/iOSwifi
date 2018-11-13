//
//  TabBarViewController.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBar.h"
#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TabBarViewController : UITabBarController<UITabBarControllerDelegate>

//自定义导航栏
+(TabBarViewController *)sharedVC;

@end

NS_ASSUME_NONNULL_END
