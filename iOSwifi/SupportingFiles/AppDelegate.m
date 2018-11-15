//
//  AppDelegate.m
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "TabBarViewController.h"
#import "UITabBar+dotSmall.h"
#import "Person.h"
#import "Person+AttrAdd.h"
#import "Person+MethodAdd.h"
#import "HelloClass.h"
#import "KVO.h"
#import "NSTimerMode.h"
#import "BackGroundTaskTimerJob.h"
#import "DownLoad.h"
#import "AppDelegate+Notification.h"
#import "DoraemonKit.h"
#import "DeviceTool.h"

@interface AppDelegate (){
    BackGroundTaskTimerJob *_backGroundTaskTimerJob;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initDoraemonKit];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CATransition *anim = [[CATransition alloc] init];
    anim.type = @"rippleEffect";
    anim.duration = 1.0;
    [self.window.layer addAnimation:anim forKey:nil];
    [self.window makeKeyAndVisible];
    [[LocationHelper sharedInstance] startLocationWithBlock:nil];
    [self initLog];
    
    [self initClass];
    //[self setAsyncGo];
    //关闭设置为NO, 默认值为NO.  键盘监听
//    [IQKeyboardManager sharedManager].enable = YES;
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //通过通知启动APP
    NSDictionary *remoteUserInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteUserInfo) {//远程通知启动App
        //[self dealPushM:remoteUserInfo];
    }else{
        self.window.rootViewController = [TabBarViewController sharedVC];
        AppDelegate *delegate = [AppDelegate appDelegate];
        UITabBarController *tabBarController = (UITabBarController *)delegate.window.rootViewController;
        tabBarController.selectedIndex = 0;
        
        [tabBarController.tabBar showBadgeOnItemIndex:1];
        
        UITabBarItem * item=[tabBarController.tabBar.items objectAtIndex:0];
        // 显示
        item.badgeValue=[NSString stringWithFormat:@"1"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            item.badgeValue =nil;
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tabBarController.tabBar hideBadgeOnItemIndex:1];
        });
    }
    
    [self initWithOptions:launchOptions];
    
    return YES;
}

- (void)initDoraemonKit {

    //调试工具
    #if defined(DEBUG) || defined(ADHOC)
        if (![LocalData isOpenDebugMode]) {
            [[DoraemonManager shareInstance] addPluginWithTitle:@"测试插件" icon:@"icon_shoppingcar_click" desc:@"测试插件" pluginName:@"TestPlugin" atModule:@"测试工具集"];
            [[DoraemonManager shareInstance] addStartPlugin:@"StartPlugin"];
            [[DoraemonManager shareInstance] addH5DoorBlock:^(NSString *h5Url) {
                NSLog(@"使用自带容器打开H5链接: %@",h5Url);
            }];
            [[DoraemonManager shareInstance] install];
        }
    #endif

}

- (void)initLog {
    [STLogService start];
}
- (void)initClass {
    
    STLog(@"MAC = %@",[DeviceTool getMacaddress]);
    
    STLog(@"Idfv = %@",[DeviceTool deviceIdfv]);
    
    STLog(@"IdfA = %@",[DeviceTool deviceIdfa]);
    
//    DownLoad *downLoad = [[DownLoad alloc] init];
//    [downLoad downLoadWithUrl:@"我是林磊" finish:^(QuickLookStorageModel *model) {
//        STLog(@"%@",model.title);
//    }];
//    [downLoad downLoadWithUrl:@"我是林磊" complete:^(NSString *str) {
//        STLog(@"%@",str);
//    }];
//    [downLoad toExcute:^(NSString *str) {
//        STLog(@"%@",str);
//    }];
    
//    _backGroundTaskTimerJob = [BackGroundTaskTimerJob jobWithTaskBlock:^{
//        //STLog(@"后台线程跑起来");
//    }];
//    [_backGroundTaskTimerJob commit];
    
//    NSTimerMode *mode = [[NSTimerMode alloc] init];
    
//    KVO *kvo = [[KVO alloc] init];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [kvo kvo];
//    });
    
    
//    HelloClass *helloClass = [[HelloClass alloc] init];
//    [HelloClass hi];
//    objc_msgSend(helloClass, @selector(testV:),@"参数");  //动态方法解析resolveInstanceMethod resolveClassMethod
//    objc_msgSend(helloClass, @selector(firstClassMethod:andStr:),@"参数s",@"Stone");//备用接收者forwordingTargetForSelector
//    objc_msgSend(helloClass, @selector(forwardInvocationMethod));//完整转发 forwardInvocation
//
//    [helloClass performSelector:@selector(testV:) withObject:@"参数===testV"];
//
//    [helloClass performSelector:@selector(firstClassMethod:andStr:) withObject:@"testV" withObject:@"testV"];
}

//- (void)initClass {
//    Person *stone = [[Person alloc] init];
//    if ([stone respondsToSelector:@selector(toPlay:andIdx:)]){
//        [stone performSelector:@selector(toPlay:andIdx:) withObject:@"厦门" withObject:@"厦门大学"];
//    }
//    objc_msgSend(stone,@selector(toDo:),@"厦门",@"鼓浪屿");
//
//    objc_msgSend(stone, @selector(toPlay:andIdx:),@"厦门",@"环岛路");
//
//    [stone performSelector:@selector(toDo:) withObject:@"厦门" withObject:@"五缘湾"];
//
//    objc_msgSend([Person class], @selector(toFunc:),@"toFunc",@"厦门",10);
//
//    //给Person类动态添加属性
//    stone.age = 24;
//    STLog(@"%ld",(long)stone.age);
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
