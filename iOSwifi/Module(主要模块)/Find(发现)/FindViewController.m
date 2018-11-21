//
//  FindViewController.m
//  iOSwifi
//
//  Created by Stone on 2018/11/11.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController () <FindViewDelegate>

@end

@implementation FindViewController

#pragma mark - LifeCycle
#pragma mark -

- (void)dealloc
{
    STLog(@"界面销毁");
}

- (instancetype)init
{
    self = [super init ];//当前对象self
    if (self !=nil) {//如果对象初始化成功，才有必要进行接下来的初始化
        STLog(@"界面初始化");
    }
    return self;//返回一个已经初始化完毕的对象；
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBaseUI:@"WiFi伴侣" sideVal:@"" backIvName:@"icon_return_black" navC:[STUIKit colorC00] midFontC:[STUIKit colorC01] sideFontC:[STUIKit colorC00] ];
    [self setUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Public Method
#pragma mark -

#pragma mark - Private Method
#pragma mark -

- (void)setUI {
    [self.view addSubview:self.findView];
    
    [self setMas];
}

- (void)setMas {
    [_findView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(StatusBarAndNaviBarH);
        make.left.equalTo(self.view);
        make.width.equalTo(@(ScreenW));
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomM);
    }];
}


#pragma mark - IB-Action
#pragma mark -


#pragma mark - Notice
#pragma mark -


#pragma mark - Delegate
#pragma mark -


#pragma mark - lazy load
#pragma mark -

- (FindView *)findView
{
    if (!_findView){
        _findView = [[FindView alloc] init];
        _findView.delegate = self; //将FindViewViewController自己的实例作为委托对象
    }
    return _findView;
}

- (NSMutableArray *)findMs
{
    if (!_findMs) {
        _findMs = [NSMutableArray array];
    }
    return _findMs;
}

@end
