//
//  FindViewController.h
//  iOSwifi
//
//  Created by Stone on 2018/11/11.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindViewController : BaseViewController

/*****上个界面传过来的值*****/
@property(nonatomic,copy)NSDictionary *staticVals;

@property(nonatomic,strong)FindView *findView;

@property (nonatomic, strong) NSMutableArray *findMs;

@end

NS_ASSUME_NONNULL_END
