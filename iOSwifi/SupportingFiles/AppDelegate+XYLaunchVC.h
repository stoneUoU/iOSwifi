//
//  AppDelegate+XYLaunchVC.h
//  iOSwifi
//
//  Created by Stone on 2018/11/15.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "AppDelegate.h"
#import "XYLaunchVC.h"
#import "XYIntroductionPage.h"

typedef NS_ENUM(NSInteger,LoadIntroductionPageWithExampleType){
    LoadIntroductionPageWithExampleType1 = 1,
    LoadIntroductionPageWithExampleType2,
    LoadIntroductionPageWithExampleType3

};

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (XYLaunchVC)

@property (nonatomic, strong) XYIntroductionPage *xyIntroductionPage;

@property (nonatomic, copy) NSArray *xyCoverImgNameArr;

@property (nonatomic, copy) NSArray *xyBgImgNameArr;

@property (nonatomic, copy) NSArray *xyCoverTitleArr;

@property (nonatomic, strong) NSMutableArray *imgGroups;

@property (nonatomic, strong) NSURL *xyVideoUrl;

@property (nonatomic, strong) XYLaunchVC *xyLaunch;

- (void)xyLoadIntroductionPageWithExampleType:(LoadIntroductionPageWithExampleType )type isAsRootVC:(BOOL )asRootVC;
//详情页代理
- (void)toAdsClick;
//进入按钮事件
- (void)toBtnClick;

@end

NS_ASSUME_NONNULL_END
