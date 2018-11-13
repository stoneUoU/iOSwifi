//
//  WFKTableViewModel.h
//  wifikey
//
//  Created by Lsh on 16/4/29.
//  Copyright © 2016年 WiFiKey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFKTableViewSectionModel.h"
#import "WFKBaseTableViewCell.h"

/**
 *  WFKTableViewModel implements some methods in UITableViewDelegate & UITableViewDataSource.
 *  it can be used as the delegate & dataSource of a tableView.
 *  For those methods it doesn't implement, you can implement them in its subclass.
 */
@interface WFKTableViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>
/** table view's section model array */
@property (nonatomic, strong) NSMutableArray<WFKTableViewSectionModel *> *sectionModelArray;
@property (nonatomic, copy) void (^scrollViewDidScrollBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^scrollViewDraggingBlock)(BOOL isDragging);

@end

