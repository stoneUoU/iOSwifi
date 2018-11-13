//
//  QuickLookStorageModel.m
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "QuickLookStorageModel.h"

@implementation QuickLookStorageModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ids" : @"id"};
}

+ (NSArray*)getPrimaryKeyUnionArray
{
    return @[@"ids"];
}

+ (LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //DB 路径
        NSString* DBPath = [NSHomeDirectory() stringByAppendingPathComponent:@"DB/model.db"];
        STLog(@"%@", DBPath);
        db = [[LKDBHelper alloc] initWithDBPath:DBPath];
    });
    return db;
}

+ (NSString *)getTableName
{
    return @"StorageTable";
}

+ (BOOL)saveStorage:(QuickLookStorageModel *)model
{
    return [model saveToDB];
}


+ (BOOL)delStorage:(QuickLookStorageModel *)model
{
    return [model deleteToDB];
}


+ (BOOL)updateStorage:(QuickLookStorageModel*)newModel WithIds:(NSString*)ids
{
    NSString *where = [NSString stringWithFormat:@"ids = '%@'", ids];
    return [QuickLookStorageModel updateToDB:newModel where:where];
}


+ (NSMutableArray*)selectAllStorages:(NSString*)ids
{
    NSString *likeContent = [NSString stringWithFormat:@"ids like '%%%@%%'", ids];
    return [QuickLookStorageModel searchWithWhere:likeContent];
}


@end


