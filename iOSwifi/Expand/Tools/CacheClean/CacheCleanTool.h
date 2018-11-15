//
//  CacheCleanTool.h
//  iOSwifi
//
//  Created by Stone on 2018/11/15.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "Singleton.h"

typedef void(^CacheSize)();

@interface CacheCleanTool : NSObject

@property (nonatomic, assign) long long cacheSize;

AS_SINGLETON(CacheCleanTool);

/**
 配置
 */
+ (void)configurateSDImageCache;

/**
 *  获取缓存目录文件大小
 */
+ (void)getCacheSize:(CacheSize )completion;

+ (void)cleanCacheCompleteBlock:(CacheSize )block;

@end
