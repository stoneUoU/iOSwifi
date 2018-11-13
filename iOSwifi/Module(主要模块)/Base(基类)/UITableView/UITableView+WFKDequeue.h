//
//  UITableViewCell+WFKDequeue.h
//  wifikey
//
//  Created by Lsh on 2018/1/26.
//  Copyright © 2018年 WiFiKey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (WFKDequeue)

- (id)dequeueReusableOrRegisterCellWithIdentifier:(NSString *)identifier;
- (id)dequeueReusableOrRegisterCellWithClass:(Class)aClass;

@end
