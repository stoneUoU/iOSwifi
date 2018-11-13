//
//  HomeViewController.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//
#import "QuickLookStorageModel.h"
#import "HomeView.h"
#import "WFKTableViewModel.h"
#import "WFKTableViewSectionModel.h"
#import "WFKTableViewCellModel.h"
#import "LocationHelper.h"

@interface HomeViewController : UIViewController<HomeViewDelegate>

//视图
@property (nonatomic,strong) HomeView *homeView;
//数据
@property (nonatomic, strong) WFKTableViewModel *tableVModel;

//广告Model:ads
@property(nonatomic ,copy) NSMutableArray* adMs;

//可用Model:wifiMs
@property(nonatomic ,copy) NSMutableArray* wifiMs;

//其他model:otherMs
@property(nonatomic ,copy) NSMutableArray* otherMs;

@end

