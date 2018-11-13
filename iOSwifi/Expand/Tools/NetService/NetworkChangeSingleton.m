//
//  NetworkChangeSingleton.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "NetworkChangeSingleton.h"
#import "Reachability.h"

@interface NetworkChangeSingleton ()

@end

@implementation NetworkChangeSingleton

#pragma mark - Init
#pragma mark -
+ (instancetype)sharedInstance {
    static NetworkChangeSingleton *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] _init];
    });
    return instance;
}

- (instancetype)_init {
    self = [super init];
    if (self) {
        [self addNotification];
    }
    return self;
}

#pragma mark - Public
#pragma mark -
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidChange:) name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundAction:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)startTest {
    NetworkStatus status = [[NetCheckTools defaultReachability] currentReachabilityStatus];
    switch (status) {
        case NotReachable: {
        }
        break;
        case ReachableViaWiFi: {
        }
        break;
        case ReachableViaWWAN: {
        }
        break;
    }
}

#pragma mark - Private
#pragma mark -
- (void)networkDidChange:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startTest];
    });
}

- (void)applicationWillEnterForegroundAction:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startTest];
    });
}

@end

