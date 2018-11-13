//
//  WFKTableViewSectionModel.m
//  wifikey
//
//  Created by Lsh on 16/4/29.
//  Copyright © 2016年 WiFiKey. All rights reserved.
//

#import "WFKTableViewSectionModel.h"

@implementation WFKTableViewSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.headerHeight = UITableViewAutomaticDimension;
        self.footerHeight = UITableViewAutomaticDimension;
        self.cellModelArray = [NSMutableArray array];
    }
    return self;
}

@end
