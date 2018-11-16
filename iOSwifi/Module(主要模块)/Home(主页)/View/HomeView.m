//
//  HomeView.m
//  iOSwifi
//
//  Created by Stone on 2018/11/11.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "HomeView.h"

@interface HomeView(){
    
}
@end

@implementation HomeView
- (id)init
{
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
}
- (void)setUpUI {
    
    _mainFont = [[UILabel alloc] init];
    _mainFont.textColor = [UIColor redColor];
    _mainFont.font = [UIFont boldSystemFontOfSize:18];
    _mainFont.text = @"WIFI钥匙";
    _mainFont.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_mainFont];
    
    //注册cell的名称
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    // 马上进入刷新状态
    [self addSubview:_tableView];

    //添加约束
    [self setMas];
}

- (void)setMas {
    [_mainFont mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(StatusBarH);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(NaviBarH);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mainFont.mas_bottom);
        make.left.equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(ScreenW);
    }];
}

- (void)toFreshDs {
    
    if (_delegate && [_delegate respondsToSelector:@selector(toFreshDs)])
    {
        // 调用代理方法
        [_delegate toFreshDs];
    }
}
@end

