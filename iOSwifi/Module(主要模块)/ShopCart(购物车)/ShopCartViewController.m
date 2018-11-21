//
//  ShopCartViewController.m
//  iOSwifi
//
//  Created by Stone on 2018/11/16.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "ShopCartViewController.h"
#import "TYTabPagerBar.h"
#import "TYPagerController.h"

@interface ShopCartViewController () <TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>

@property (nonatomic, strong) TYTabPagerBar *tabPagerBar;
@property (nonatomic, strong) TYPagerController *pagerController;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTabPageBar];
    
    [self addPagerController];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)addTabPageBar {
    _tabPagerBar = [[TYTabPagerBar alloc] init];
    _tabPagerBar.contentInset = UIEdgeInsetsMake(StatusBarH, 0, 0, 0);
    _tabPagerBar.backgroundColor = [STUIKit colorC00];
    _tabPagerBar.backgroundColor = [STUIKit colorC00];
    _tabPagerBar.layer.shadowColor = [UIColor grayColor].CGColor;
    _tabPagerBar.layer.shadowOffset = CGSizeMake(0, 0);
    _tabPagerBar.layer.shadowRadius = 3;
    _tabPagerBar.layer.shadowOpacity = 0.15;
    
    _tabPagerBar.layout.normalTextFont = [STUIKit fontF02];
    _tabPagerBar.layout.normalTextColor = [STUIKit colorC15];
    _tabPagerBar.layout.selectedTextFont = [STUIKit fontF017];
    _tabPagerBar.layout.selectedTextColor = [STUIKit colorC16];
    _tabPagerBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    _tabPagerBar.layout.progressColor = [STUIKit colorC17];
    _tabPagerBar.layout.progressWidth = 20;
    _tabPagerBar.layout.progressHeight = 2;
    _tabPagerBar.layout.progressRadius = 1;
    _tabPagerBar.layout.cellSpacing = 0;
    _tabPagerBar.layout.sectionInset = UIEdgeInsetsZero;
    _tabPagerBar.dataSource = self;
    _tabPagerBar.delegate = self;
    [_tabPagerBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:_tabPagerBar];
    //布局
    [_tabPagerBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(StatusBarAndNaviBarH);
    }];
}

- (void)addPagerController {
    _pagerController = [[TYPagerController alloc]init];
    _pagerController.layout.prefetchItemCount = 1;
    _pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    _pagerController.dataSource = self;
    _pagerController.delegate = self;
    [self addChildViewController:_pagerController];
    [self.view addSubview:_pagerController.view];
    [_pagerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(StatusBarAndNaviBarH);
    }];
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    [datas addObject:@"推荐"];
    [datas addObject:@"娱乐"];
    [datas addObject:@"图片"];
    [datas addObject:@"内涵段子"];
    [datas addObject:@"科技"];
    [datas addObject:@"汽车"];
    _datas = [datas copy];
    
    [self reloadData];
}

#pragma mark - TYTabPagerBarDataSource

- (NSInteger)numberOfItemsInPagerTabBar {
    return _datas.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = _datas[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate
#pragma mark -

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    return ScreenW / 6.0;
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController {
    return 20;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    UIViewController *VC = [[UIViewController alloc]init];
    VC.view.backgroundColor = [UIColor whiteColor];
    return VC;
}

#pragma mark - TYPagerControllerDelegate

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabPagerBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabPagerBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)reloadData {
    [_tabPagerBar reloadData];
    [_pagerController reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
