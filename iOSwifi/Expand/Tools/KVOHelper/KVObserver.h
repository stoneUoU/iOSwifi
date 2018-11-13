//
//  KVObserver.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KVObserverValueSimplifyBlock)(NSString *keyPath,NSDictionary<NSKeyValueChangeKey,id> * change) ;
typedef void (^KVObserverValueComplexBlock)(NSString *keyPath,id ofObject,NSDictionary<NSKeyValueChangeKey,id> * change,void * context);

@interface KVObserver : NSObject

@property(copy, nonatomic) KVObserverValueSimplifyBlock simplifyBlock;
@property(copy, nonatomic) KVObserverValueComplexBlock  complexBlock;

/**
 options 默认 NSKeyValueObservingOptionNew,
 */
+ (instancetype)observerForkeyPath:(NSString *)keyPath ofObject:(NSObject *)object;
+ (instancetype)observerForkeyPath:(NSString *)keyPath ofObject:(NSObject *)object options:(NSKeyValueObservingOptions)options context:(void *)context;

- (void)clean;

@end
