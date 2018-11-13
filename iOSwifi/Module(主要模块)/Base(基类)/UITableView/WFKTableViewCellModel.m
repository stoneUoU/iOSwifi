//
//  WFKTableViewCellModel.m
//  wifikey
//
//  Created by Lsh on 16/4/29.
//  Copyright © 2016年 WiFiKey. All rights reserved.
//

#import "WFKTableViewCellModel.h"

@implementation WFKTableViewCellModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.height = UITableViewAutomaticDimension;
    }
    return self;
}

@end
