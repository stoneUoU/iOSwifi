//
//  HomeViewController.m
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "HomeViewController.h"
#import "LocalData.h"
#import "LKDBHelper.h"
#import "TableVCell.h"
#import "PermissionHelper.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init
{
    self = [super init ];//当前对象self
    if (self !=nil)//如果对象初始化成功，才有必要进行接下来的初始化
    {
        _homeView = [[HomeView alloc] init]; //对HomeView进行初始化
        _homeView.tableView.dataSource = self.tableVModel;
        _homeView.tableView.delegate   = self.tableVModel;
        _homeView.backgroundColor = [UIColor color_HexStr:@"#F5F5F5"];
        _homeView.delegate = self;
        _adMs = [NSMutableArray array];
        _wifiMs = [NSMutableArray array];
        _otherMs = [NSMutableArray array];
    }
    return self;//返回一个已经初始化完毕的对象；
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    [self initDatas];
    
    [self testLocalData];
    //[self addObservers];
    //[self boardNewThread];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toDo) name:STLocationHelpDidChangeAuthorizationStatussNotication object:nil];
    
    if ([PermissionHelper isLocationAvailable]) {
        STLog(@"111");
    } else {
        STLog(@"222");
    }
    
    STLog(@"%@",[VCTools getTarBarSelectVC]);
    
}

- (void)toDo {
    STLog(@"999999999999");
}

- (void)setUI{
    [self.view addSubview:_homeView];
    //添加约束
    [self setMas];
}

- (void)setGCDGroup{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求1
        STLog(@"Request_1");
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求2
        sleep(3.0);
        STLog(@"Request_2");
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求3
        STLog(@"Request_3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //界面刷新
        STLog(@"任务均完成，刷新界面");
    });
}

- (void) setMas{
    [_homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH - TabBarH);
    }];
}
//- (void)boardNewThread{
//    [NSThread detachNewThreadSelector:@selector(toDownLoad) toTarget:self withObject:nil];
//
//}
//- (void)toDownLoad{
//    DownLoad *downLoad = [[DownLoad alloc] init];
//    [downLoad downLoadWithUrl:@"我是林磊" finish:^(QuickLookStorageModel *ocMs) {
//        STLog(@"%@",ocMs.product_name);
//    }];
//    [downLoad downLoadWithUrl:@"我是林磊" complete:^(NSString *str) {
//        STLog(@"%@",str);
//    }];
//}

- (void)initDatas{
    //广告model:
    for (int i = 0; i < 2; i++) {
        QuickLookStorageModel *model = [[QuickLookStorageModel alloc] init];
        model.title = @"UUUmUUU_1";
        [_adMs addObject:model];
    }
    //wifi的model:
    for (int i = 1; i < 3; i++) {
        QuickLookStorageModel *model = [[QuickLookStorageModel alloc] init];
        model.title = @"UUUmUUU_2";
        [_wifiMs addObject:model];
    }
    //其他wifi的model:
    for (int i = 0; i < 3; i++) {
        QuickLookStorageModel *model = [[QuickLookStorageModel alloc] init];
        model.title = @"UUUmUUU_3";
        [_otherMs addObject:model];
    }
    for (int i = 0; i < _adMs.count; i++) {
        [self.tableVModel.sectionModelArray addObject:[self cellAdsSect:_adMs[i]]];
    }
    [self.tableVModel.sectionModelArray addObject:[self cellWifiSect]];
    [self.tableVModel.sectionModelArray addObject:[self cellOtherSect]];
    [self.homeView.tableView reloadData];
}
#pragma mark - WFKTableViewModel 懒加载
- (WFKTableViewModel *)tableVModel {
    if (!_tableVModel) {
        //@weakify(self);
        _tableVModel = [[WFKTableViewModel alloc] init];
    }
    return _tableVModel;
}

#pragma mark - WFKTableViewSectionModel 懒加载
- (WFKTableViewSectionModel *)cellAdsSect:(QuickLookStorageModel *)model{
    WFKTableViewSectionModel *sectionModel = [[WFKTableViewSectionModel alloc] init];
    sectionModel.headerHeight = 30;
    sectionModel.footerHeight = 0.001;
    WFKTableViewCellModel * cellModel = [self InCellWithModel:model];
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        //        QuickLookStorageModel *ocMs = _adMs[indexPath.section];
        //        STLog(@"%@",ocMs.product_name);
        //        [WBUrlManager handleUrl:[WBUrlManager urlWithKey:kWBConnectInfoKey param:@{@"name":@"我是林磊"}]];
        //        [NSThread detachNewThreadWithBlock:^{
//        STLog(@"发送通知线程：%@",[NSThread currentThread]);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"sonThreadPostNotice" object:nil];
//        //}];
//        STLog(@"%@",model.name);
        
        UIViewController *vc = [[CTMediator sharedInstance] st_mediator_toVCWithParams:@{@"林磊":@"林磊"}];
        //[self.navigationController pushViewController:vc animated:YES];
        [VCTools pushToNextVC:self destVC:vc];
        
        [LocalData saveDebugModeStatus:![LocalData isOpenDebugMode]];
        
    };
    if (cellModel) {
        [sectionModel.cellModelArray addObject:cellModel];
    }
    return sectionModel;
}
#pragma mark - WFKTableViewSectionModel 懒加载
- (WFKTableViewSectionModel *)cellWifiSect{
    WFKTableViewSectionModel *sectionModel = [[WFKTableViewSectionModel alloc] init];
    sectionModel.headerHeight = 0.001;
    sectionModel.footerHeight = 0.001;
    for (QuickLookStorageModel *i in _wifiMs) {
        WFKTableViewCellModel * cellModel = [self InCellWithModel:i];
        if (cellModel) {
            [sectionModel.cellModelArray addObject:cellModel];
        }
    }
    WFKTableViewCellModel * cellFreeModel = [self InCellWithFindModel];
    [sectionModel.cellModelArray addObject:cellFreeModel];
    return sectionModel;
}
- (WFKTableViewCellModel *)InCellWithModel:(QuickLookStorageModel *)model{
    WFKTableViewCellModel *cellModel = [[WFKTableViewCellModel alloc] init];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        TableVCell *cell = [TableVCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.model = model;
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        
    };
    return cellModel;
}
#pragma mark - WFKTableViewSectionModel 懒加载
- (WFKTableViewSectionModel *)cellOtherSect {
    WFKTableViewSectionModel *sectionModel = [[WFKTableViewSectionModel alloc] init];
    sectionModel.headerHeight = 30;
    sectionModel.footerHeight = 0.001;
    sectionModel.headerViewRenderBlock = ^UIView *(NSInteger section, UITableView *tableView) {
        UIView *headerView = [[UIView alloc] init];
        return headerView;
    };
    sectionModel.footerViewRenderBlock = ^UIView *(NSInteger section, UITableView *tableView) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor greenColor];
        return footerView;
    };
    for (QuickLookStorageModel *i in _otherMs) {
        WFKTableViewCellModel * cellModel = [self InCellWithOtherModel:i];
        if (cellModel) {
            [sectionModel.cellModelArray addObject:cellModel];
        }
    }
    return sectionModel;
}
- (WFKTableViewCellModel *)InCellWithOtherModel:(QuickLookStorageModel *)model{
    WFKTableViewCellModel *cellModel = [[WFKTableViewCellModel alloc] init];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        TableVCell *cell = [TableVCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.model = model;
        return cell;
    };
    return cellModel;
}
- (WFKTableViewCellModel *)InCellWithFindModel{
    WFKTableViewCellModel *cellModel = [[WFKTableViewCellModel alloc] init];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        TableVCell *cell = [TableVCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        QuickLookStorageModel *model = [[QuickLookStorageModel alloc] init];
        model.title = @"UUUmUUU_find";
        
        cell.model = model;
        return cell;
    };
    return cellModel;
}

#pragma mark - HomeViewDelegate

- (void)toFreshDs{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STLog(@"888888888");
    });
}

/*****************  test LocalData and LKDBHelper  ****************/

- (void)testLocalData {
    //[LocalData setObject:@{@"name":@"Stone"} forKey:@"stoneKey"];

    QuickLookStorageModel *model = [[QuickLookStorageModel alloc] init];
    model.ids = 66;
    model.title = @"OOOvOOO";
    model.phone = @"Stone omo";
    model.pic_url = @"OOOOOOOOOO";

    [QuickLookStorageModel saveStorage:model];

    [QuickLookStorageModel updateStorage:model WithIds:@"66"];

    QuickLookStorageModel *xiaoM = [QuickLookStorageModel selectAllStorages:@"66"][0];

    STLog(@"%@",xiaoM.title);
    
//    if ([LocalData appEnvi]) {
//        STLog(@"88888888");
//    } else {
//        STLog(@"99999999");
//    };
    
}

//- (void)setCalu{
//    BOOL UoU = YES;
//    //三元运算符
//    !UoU ?:STLog(@"88888");
//}


////添加通知:
//- (void)addObservers{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toNoticeDone) name:@"sonThreadPostNotice" object:nil];
//}
//- (void)toNoticeDone{
//    sleep(3.0);
//    STLog(@"接到通知线程：%@",[NSThread currentThread]);
//    //[self getScreenShot];
//}
@end


