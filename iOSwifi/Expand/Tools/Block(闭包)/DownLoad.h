//
//  DownLoad.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickLookStorageModel.h"

typedef void(^FinishCompletion)(NSString * str);
typedef void(^ModelCompletion)(QuickLookStorageModel * model);

typedef void(^FirstFinish)(NSString *str);

typedef void(^SecondFinish)(NSString *str);

typedef void(^ThirdFinish)(NSString *str);


NS_ASSUME_NONNULL_BEGIN

@interface DownLoad : NSObject

- (void)downLoadWithUrl:(NSString *)urlStr complete:(FinishCompletion)success;

- (void)downLoadWithUrl:(NSString *)urlStr finish:(ModelCompletion)success;

- (void)toExcute:(FinishCompletion)success;

@end

NS_ASSUME_NONNULL_END
