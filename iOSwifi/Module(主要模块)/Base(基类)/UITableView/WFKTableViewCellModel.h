//
//  WFKTableViewCellModel.h
//  wifikey
//
//  Created by Lsh on 16/4/29.
//  Copyright © 2016年 WiFiKey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef UITableViewCell * (^WFKCellRenderBlock)(NSIndexPath *indexPath, UITableView *tableView);
typedef NSIndexPath * (^WFKCellWillSelectBlock)(NSIndexPath *indexPath, UITableView *tableView);
typedef void (^WFKCellSelectionBlock)(NSIndexPath *indexPath, UITableView *tableView);
typedef void (^WFKCellWillDisplayBlock)(UITableViewCell *cell, NSIndexPath *indexPath, UITableView *tableView);
typedef void (^WFKCellCommitEditBlock)(NSIndexPath *indexPath, UITableView *tableView, UITableViewCellEditingStyle editingStyle);

/** Table view's row model */
@interface WFKTableViewCellModel : NSObject

@property (nonatomic, copy) WFKCellRenderBlock renderBlock;            // required
@property (nonatomic, copy) WFKCellWillDisplayBlock willDisplayBlock;  // optional
@property (nonatomic, copy) WFKCellWillSelectBlock willSelectBlock;    // optional
@property (nonatomic, copy) WFKCellWillSelectBlock willDeselectBlock;  // optional
@property (nonatomic, copy) WFKCellSelectionBlock selectionBlock;      // optional
@property (nonatomic, copy) WFKCellSelectionBlock deselectionBlock;    // optional
@property (nonatomic, copy) WFKCellCommitEditBlock commitEditBlock;    // optional
@property (nonatomic, assign) CGFloat height;  // optional
@property (nonatomic, assign) BOOL canEdit;    // default NO
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;  // cell's editing style
@property (nonatomic, copy) NSString *deleteConfirmationButtonTitle;  // delete confirmation title

@end
