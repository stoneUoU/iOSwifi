//
//  WFKBaseTableViewCell.h
//  wifikey
//
//  Created by Lsh on 16/4/28.
//  Copyright © 2016年 WiFiKey. All rights reserved.
//

#import "WFKViewDefine.h"
#import "UITableView+WFKDequeue.h"

@interface WFKBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) float cellHeight;

AS_WFKCUSTOMCELL(WFKBaseTableViewCell);

@end
