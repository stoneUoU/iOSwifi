//
//  BackGroundTaskJob.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BackGroundTaskJobBlock)();

@interface BackGroundTaskJob : NSObject


/**
 初始化工作
 
 @param taskBlock 要执行的动作Block,异步执行在串行队列里
 
 @return BackGroundTaskJob
 */
+ (instancetype)jobWithTaskBlock:(BackGroundTaskJobBlock)taskBlock;

- (void)commit;

//异步执行在串行队列里
- (void)done;

- (void)cancle;

@end
