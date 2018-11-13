//
//  DownLoad.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "DownLoad.h"

@interface DownLoad()

@property (nonatomic,copy) FinishCompletion finish;

@property (nonatomic,copy) ModelCompletion success;

@property (nonatomic,copy) FirstFinish firstFinish;

@property (nonatomic,copy) SecondFinish secondFinish;

@property (nonatomic,copy) ThirdFinish thirdFinish;

@end

@implementation DownLoad


- (void)downLoadWithUrl:(NSString *)urlStr complete:(FinishCompletion)success{
    
    _finish = success;
    
    [self downLoadInFunc];
};

- (void)downLoadInFunc{
    
    NSString * str = @"从这个网址下载数据";
    
    _finish(str);
}

- (void)downLoadWithUrl:(NSString *)urlStr finish:(ModelCompletion)success{
    QuickLookStorageModel *model = [[QuickLookStorageModel alloc] init];
    model.ids = 1;
    model.title = @"我是林磊";
    model.phone = @"999999";
    model.pic_url = @"YYYYYYYYYYYY";
    success(model);
}

- (void)toExcute:(FinishCompletion)success{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self startFirstB:@"FirstB" complete:^(NSString *str) {
            STLog(@"%@",str);
            [self startSecondB:@"SecondB" complete:^(NSString *str) {
                STLog(@"%@",str);
                [self startThirdB:@"ThirdB" complete:^(NSString *str) {
                    STLog(@"%@",str);
                    success(str);
                }];
            }];
        }];
    });
}

- (void)startFirstB:(NSString *)urlStr complete:(void (^)(NSString * str))success{
    
    _firstFinish = success;
    
    sleep(1.0);
    
    _firstFinish(urlStr);
};

- (void)startSecondB:(NSString *)urlStr complete:(void (^)(NSString * str))success{
    
    _secondFinish = success;
    
    sleep(2.0);
    
    _secondFinish(urlStr);
};

- (void)startThirdB:(NSString *)urlStr complete:(void (^)(NSString * str))success{
    
    _thirdFinish = success;
    
    sleep(3.0);
    
    _thirdFinish(urlStr);
};

@end

