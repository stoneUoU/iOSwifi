//
//  AppDelegate+XYLaunchVC.m
//  iOSwifi
//
//  Created by Stone on 2018/11/15.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "AppDelegate+XYLaunchVC.h"
#import "TabBarViewController.h"
#import "FindViewController.h"
@implementation AppDelegate (XYLaunchVC)
#pragma mark-xy ---------------------------------引导页-------------------------------

- (void)xyLoadIntroductionPageWithExampleType:(LoadIntroductionPageWithExampleType )type{
    //可以更换样式,分别为:example1,example2,example3,example4,example5
    switch (type) {
            case LoadIntroductionPageWithExampleType1:
            {
                self.xyIntroductionPage = [self example1];
                self.window.rootViewController = [[TabBarViewController alloc] init];
                [self.window addSubview:self.xyIntroductionPage.view];
            }
            break;
            case LoadIntroductionPageWithExampleType2:
            {
                [self xyAdLaunch];
            }
            break;
        default:
            break;
    }
}
//传统引导页
- (XYIntroductionPage *)example1{
    //可以添加gif动态图哦
    self.xyBgImgNameArr = @[@"loading1", @"loading2", @"loading3"];
    XYIntroductionPage * xyPage = [[XYIntroductionPage alloc]init];
    xyPage.xyCoverImgArr = self.xyBgImgNameArr;//设置浮层滚动图片数组
    xyPage.xyDelegate = self;//进入按钮事件代理
    xyPage.xyAutoScrolling = NO;//是否自动滚动
    xyPage.xyPageControl.hidden = YES;
    //可以自定义设置进入按钮样式
    [xyPage.xyEnterBtn setTitle:@"立即进入" forState:UIControlStateNormal];
    return xyPage;
}

#pragma mark-xy 启动页2 -广告
- (void)xyAdLaunch{
    self.xyLaunch = [[XYLaunchVC alloc]initWithRootVC:[[TabBarViewController alloc] init] withLaunchType:XYLaunchAD];
    self.xyLaunch.xyAdDuration = 60;
    self.xyLaunch.xyDelegate = self;
    self.xyLaunch.xyAdActionUrl = @"https://www.baidu.com";
    //_xyLaunch.xyIsCloseTimer = YES;//跟引导页(XYIntroductionPage)一起用的时候要打开/否则关闭
    // 网络
    self.xyLaunch.xyAdImgUrl = @"https://bpic.588ku.com/element_banner/20/18/11/b91a2c0c524a7ba04b02a686aeb397d0.jpg!/unsharp/true/compress/true";
    // 本地
    self.window.rootViewController = self.xyLaunch;
    
}

//详情页代理
- (void)toAdsClick {
    
    [self.xyLaunch performSelector:@selector(xySkipTap) withObject:nil];
    //STLog(@"%@",[VCTools getCurrVC]);
    //[[VCTools getCurrVC].navigationController pushViewController:[[FindViewController alloc] init] animated:YES];
};

//进入按钮事件
- (void)toBtnClick {
    self.xyIntroductionPage = nil;
    [UICKeyChainStore keyChainStore][@"firstInA"] =@"true";
    [self.xyLaunch xy_startFire];//和引导页(XYIntroductionPage)一起用的时候加上这句
};


#pragma mark - Getter & Setter
#pragma mark -
- (void)setXyIntroductionPage:(XYIntroductionPage *)xyIntroductionPage {
    objc_setAssociatedObject(self, @"xyIntroductionPage", xyIntroductionPage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setXyCoverImgNameArr:(NSArray *)xyCoverImgNameArr {
    objc_setAssociatedObject(self, @"xyCoverImgNameArr", xyCoverImgNameArr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setXyBgImgNameArr:(NSArray *)xyBgImgNameArr {
    objc_setAssociatedObject(self, @"xyBgImgNameArr", xyBgImgNameArr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setXyCoverTitleArr:(NSArray *)xyCoverTitleArr {
    objc_setAssociatedObject(self, @"xyCoverTitleArr", xyCoverTitleArr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setXyVideoUrl:(NSURL *)xyVideoUrl {
    objc_setAssociatedObject(self, @"xyVideoUrl", xyVideoUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setXyLaunch:(XYLaunchVC *)xyLaunch {
    objc_setAssociatedObject(self, @"xyLaunch", xyLaunch, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (XYIntroductionPage *)xyIntroductionPage {
    return objc_getAssociatedObject(self, @"xyIntroductionPage");
}
- (NSArray *)xyCoverImgNameArr {
    return objc_getAssociatedObject(self, @"xyCoverImgNameArr");
}
- (NSArray *)xyBgImgNameArr {
    return objc_getAssociatedObject(self, @"xyBgImgNameArr");
}
- (NSArray *)xyCoverTitleArr {
    return objc_getAssociatedObject(self, @"xyCoverTitleArr");
}
- (NSURL *)xyVideoUrl {
    return objc_getAssociatedObject(self, @"xyVideoUrl");
}
- (XYLaunchVC *)xyLaunch {
    return objc_getAssociatedObject(self, @"xyLaunch");
}

@end
