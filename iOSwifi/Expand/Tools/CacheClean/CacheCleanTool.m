//
//  CacheCleanTool.m
//  iOSwifi
//
//  Created by Stone on 2018/11/15.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "CacheCleanTool.h"
#import "SDImageCache.h"
#import "SDImageCacheConfig.h"

@implementation CacheCleanTool

DEF_SINGLETON(CacheCleanTool);

+ (void)configurateSDImageCache
{
    [SDImageCache sharedImageCache].config.shouldDecompressImages = NO;
    [SDImageCache sharedImageCache].config.maxCacheSize = 1024 * 1024 * 50;
}

+ (void)getCacheSize:(CacheSize )completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSFileManager* manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:cachePath]) {
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(0);
                });
            }
        }else {
            NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachePath] objectEnumerator];
            NSString* fileName;
            long long folderSize = 0;
            while ((fileName = [childFilesEnumerator nextObject]) != nil){
                NSString* fileAbsolutePath = [cachePath stringByAppendingPathComponent:fileName];
                folderSize += [self fileSizeAtPath:fileAbsolutePath];
            }
            
            [[CacheCleanTool sharedInstance] setCacheSize:folderSize];
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(folderSize);
                });
            }
        }
    });
}

+ (long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (void)cleanCacheCompleteBlock:(CacheSize )block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        [[SDImageCache sharedImageCache] clearMemory];
        
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        for (NSString *p in files) {
            NSError *error;
            NSString *Path = [cachePath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
                [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CacheCleanTool sharedInstance] setCacheSize:0];
            if (block) {
                block();
            }
        });
    });
}

@end
