//
//  HomeView.h
//  iOSwifi
//
//  Created by Stone on 2018/11/11.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeViewDelegate

//这里只需要声明方法
- (void)toFreshDs; //下拉刷新

@end

@interface HomeView : BaseView

@property (nonatomic ,strong)UILabel *mainFont;

@property (nonatomic ,strong)UITableView *tableView;

@property (nonatomic ,weak)id<HomeViewDelegate> delegate; //定义一个ConnectVDel属性

@end

NS_ASSUME_NONNULL_END
