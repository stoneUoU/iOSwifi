//
//  WFKTableViewSectionModel.h
//  wifikey
//
//  Created by Lsh on 16/4/29.
//  Copyright © 2016年 WiFiKey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFKTableViewCellModel.h"

typedef UIView * (^WFKViewRenderBlock)(NSInteger section, UITableView *tableView);

/** Table view's section model */
@interface WFKTableViewSectionModel : NSObject

@property (nonatomic, strong) NSMutableArray<WFKTableViewCellModel *> *cellModelArray;
@property (nonatomic, strong) NSString *headerTitle;  // optional
@property (nonatomic, strong) NSString *footerTitle;  // optional
@property (nonatomic, assign) CGFloat headerHeight;  // optional
@property (nonatomic, assign) CGFloat footerHeight;  // optional

// view render blocks' priority is higher then view property.
// e.g. if headerViewRenderBlock and headerView are both provided, headerViewRenderBlock will be
// used
@property (nonatomic, copy) WFKViewRenderBlock headerViewRenderBlock;  // block to render header
// view
@property (nonatomic, copy) WFKViewRenderBlock footerViewRenderBlock;  // block to render footer
// view
@property (nonatomic, strong) UIView *headerView;  // section header view
@property (nonatomic, strong) UIView *footerView;  // section footer view

@end

