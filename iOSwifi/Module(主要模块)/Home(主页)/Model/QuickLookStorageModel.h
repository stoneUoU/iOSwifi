//
//  QuickLookStorageModel.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
NS_ASSUME_NONNULL_BEGIN

@interface QuickLookStorageModel : NSObject

//id
@property (nonatomic, assign) NSInteger ids;

//标题
@property (nonatomic, copy) NSString *title;

//备注
@property (nonatomic, copy) NSString *desc;

//手机号码
@property (nonatomic, copy) NSString *phone;

//图片存储路径
@property (nonatomic, copy) NSString *pic_url;


+ (BOOL)saveStorage:(QuickLookStorageModel *)model;

+ (BOOL)delStorage:(QuickLookStorageModel *)model;

+ (BOOL)updateStorage:(QuickLookStorageModel*)newModel WithIds:(NSString*)ids;

+ (NSMutableArray*)selectAllStorages:(NSString*)ids;

@end

NS_ASSUME_NONNULL_END
