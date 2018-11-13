//
//  YYCacheTools.h
//  Gstore
//
//  Created by test on 2018/5/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCacheTools : NSObject

+ (void)setResCache:(id)httpData url:(NSString *)url;

+ (id)resCacheForURL:(NSString *)url;

+ (NSInteger)getAllResCacheSize;

+ (void)removeAllResCache;

+ (void)removeAppointedResCache:(NSString *)url;

+ (BOOL)isCacheExist:(NSString *)url;

@end
