//
//  Target_Freshs.m
//  GCDTest
//
//  Created by test on 2018/7/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "Target_Freshs.h"
#import "FindViewController.h"

@implementation Target_Freshs

- (UIViewController *)Action_ToHomeModeViewController:(NSDictionary *)params {
    FindViewController *findView = [[FindViewController alloc] init];
    if (params) {
        findView.staticVals = params;
    }
    return findView;
}
@end
