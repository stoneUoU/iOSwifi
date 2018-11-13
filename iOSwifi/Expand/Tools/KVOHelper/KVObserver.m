//
//  KVObserver.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "KVObserver.h"

@interface KVObserver ()

@property(nonatomic, strong) NSObject *sourceObjcet;
@property(nonatomic, copy  ) NSString *keyPath;

@end

@implementation KVObserver

+ (instancetype)observerForkeyPath:(NSString *)keyPath ofObject:(NSObject *)object
{
    return  [self observerForkeyPath:keyPath ofObject:object options:NSKeyValueObservingOptionNew context:nil];
}

+ (instancetype)observerForkeyPath:(NSString *)keyPath ofObject:(NSObject *)object options:(NSKeyValueObservingOptions)options context:(void *)context
{
    return [[self alloc] initForkeyPath:keyPath ofObject:object options:options context:context];
}

- (instancetype)initForkeyPath:(NSString *)keyPath ofObject:(NSObject *)object options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if(self = [super init])
    {
        self.sourceObjcet = object;
        self.keyPath = keyPath;
        
        [object addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (self.simplifyBlock) {
        self.simplifyBlock(keyPath,change);
    }
    
    if (self.complexBlock) {
        self.complexBlock(keyPath,object,change,context);
    }
}

- (void)clean
{
    if (self.keyPath) {
        [self.sourceObjcet removeObserver:self forKeyPath:self.keyPath];
    }
}

@end

