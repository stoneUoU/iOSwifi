//
//  TableVCell.h
//  iOSwifi
//
//  Created by Stone on 2018/11/11.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuickLookStorageModel;

@interface TableVCell : UITableViewCell

@property (nonatomic, strong) QuickLookStorageModel *model;

AS_WFKCUSTOMCELL(TableVCell);

@end

