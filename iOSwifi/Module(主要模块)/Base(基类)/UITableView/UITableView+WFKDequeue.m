//
//  UITableView+WFKDequeue.m
//  wifikey
//
//  Created by Lsh on 2018/1/26.
//  Copyright © 2018年 WiFiKey. All rights reserved.
//

#import "UITableView+WFKDequeue.h"

@implementation UITableView (WFKDequeue)

- (UITableViewCell *)dequeueReusableOrRegisterCellWithIdentifier:(NSString *)identifier{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
        cell = [self dequeueReusableCellWithIdentifier:identifier];
    }

    return cell;
}

- (UITableViewCell *)dequeueReusableOrRegisterCellWithClass:(Class)aClass{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(aClass)];

    if (!cell) {
        [self registerClass:aClass forCellReuseIdentifier:NSStringFromClass(aClass)];
        cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(aClass)];
    }

    return cell;
}

@end
