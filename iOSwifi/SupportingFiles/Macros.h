//
//  Macros.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//
#import "LocalData+Store.h"

//设计师设计以iphone6为原型：
#define iphoneSixW 375

//以6/6s为准宽度缩小系数
#define StScaleW                        [UIScreen mainScreen].bounds.size.width/375.0

//高度缩小系数
#define StScaleH                        [UIScreen mainScreen].bounds.size.height/667.0

// UIScreen.
#define  ScreenInfo                     [UIScreen mainScreen].bounds.size
// UIScreen width.
#define  ScreenW                        [UIScreen mainScreen].bounds.size.width
// UIScreen height.
#define  ScreenH                        [UIScreen mainScreen].bounds.size.height

#define  isIpad                         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define  isIphone                       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define  isRetain                       ([[UIScreen mainScreen] scale] >= 2.0)
// iPhone 4
#define  isIphone4                      (SCREEN_MAX_LENGTH/3 == SCREEN_MIN_LENGTH/2)
// iPhone 5之前
#define  isIphone5Before                (isIphone && SCREEN_MAX_LENGTH < 568.0)
// iPhone SE
#define  isSE                           (ScreenW == 320.f && ScreenH == 568.f ? YES : NO)
// iPhone 8
#define  isIphone8                      (isIphone && SCREEN_MAX_LENGTH == 667.0)
// iPhone 8Plus
#define  isIphone8Plus                  (isIphone && SCREEN_MAX_LENGTH == 736.0)
// iPhone X
#define  isX                            (ScreenW == 375.f && ScreenH == 812.f ? YES : NO)
// iPhone Xr
#define  isXr                           (ScreenW == 414.f && ScreenH == 896.f ? YES : NO)

#define kPackageName                    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define  appleSysVersion                ([[[UIDevice currentDevice] systemVersion] floatValue])
#define  iOS10                          (appleSysVersion >= 10.0f)
#define  iOS11                          (appleSysVersion >= 11.0f)

// Status bar height.
#define  StatusBarH                     ((isX || isXr) ? 44.f : 20.f)
// Navigation bar height.
#define  NaviBarH                       44.f
// Tabbar height.
#define  TabBarH                        ((isX || isXr) ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  TabbarSafeBottomM              ((isX || isXr) ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  StatusBarAndNaviBarH           ((isX || isXr) ? 88.f : 64.f)

#define ViewSafeAreInsets(view)         ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

/*测试环境*/
#define __DEBUGMODELSERVICE__           [LocalData appEnvi]
//测试服务器
#define TestHost                        @"https://app.shop.znrmny.com/"
//线上服务器
#define OnlineHost                      @"https://app.shop.znrmny.com/"
//一级域名
#define  GfoodsURL                      __DEBUGMODELSERVICE__ ? TestHost : OnlineHost

#define picUrl                          [NSString stringWithFormat:@"%@static/ggshop/v5", GfoodsURL];

////定义BaseURL后面的一戳
#define followRoute                     @"api/ggshop/member/v5/"

//请求超时时间
#define timeoutTime                     6.0
//没网时的提示
#define missNetTips                     @"网络开小差啦，请检查网络"
//登录失效的提示
#define missSsidTips                    @"登录失效，请重新登录"
