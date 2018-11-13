//
//  YYCacheTools.m
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "YYCacheTools.h"
#import "YYCache.h"

static NSString *const resCache = @"resCache";
static YYCache *_dataCache;
@implementation YYCacheTools
+ (void)initialize {
    _dataCache = [YYCache cacheWithName:resCache];
}
+ (void)setResCache:(id)httpData url:(NSString *)url {
    NSString *cacheKey = url;
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}
//取缓存
+ (id)resCacheForURL:(NSString *)url {
    NSString *cacheKey = url;
    return [_dataCache objectForKey:cacheKey];
}
//判断缓存是否存在
+ (BOOL)isCacheExist:(NSString *)url {
    BOOL isContains=[_dataCache containsObjectForKey:url];
    return isContains;
}
+ (void)removeAppointedResCache:(NSString *)url{
    //根据key移除缓存
    [_dataCache.diskCache removeObjectForKey:url withBlock:^(NSString * _Nonnull url) {
        STLog(@"removeObjectForKey %@",url);
    }];
}
+ (NSInteger)getAllResCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllResCache {
    [_dataCache.diskCache removeAllObjects];
}

@end
