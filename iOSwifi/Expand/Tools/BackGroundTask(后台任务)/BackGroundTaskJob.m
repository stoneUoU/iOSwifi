//
//  BackGroundTaskJob.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "BackGroundTaskJob.h"
#import "BackGroundTaskTimerJob.h"

#define  isInBackGround ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)

#pragma mark -
#pragma mark - BackGroundTaskManager

@interface BackGroundTaskManager : NSObject

@property(nonatomic, strong) NSMutableArray *jobs;
@property(nonatomic, strong) NSMutableArray *timerJobs;

@property(nonatomic, strong) dispatch_queue_t  queue;
@property(nonatomic, strong) dispatch_source_t backGroundTaskJobsTimer;
@property(nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskId;

+ (instancetype)shareManager;
- (void)addJob:(BackGroundTaskJob *)job;

@end

@implementation BackGroundTaskManager

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareManager
{
    static BackGroundTaskManager *backGroundTaskManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        backGroundTaskManager = [BackGroundTaskManager new];
    });
    return backGroundTaskManager;
}

- (void)addJob:(BackGroundTaskJob *)job
{
    [self setupNotification];
    if ([job isMemberOfClass:[BackGroundTaskJob class]])
    {
        @synchronized (self.jobs) {
            if (![self.jobs containsObject:job])
            {
                [self.jobs addObject:job];
            }
        }
    }else if([job isMemberOfClass:[BackGroundTaskTimerJob class]])
    {
        @synchronized (self.timerJobs) {
            if (![self.timerJobs containsObject:job])
            {
                [self.timerJobs addObject:job];
            }
        }
    }
}

- (void)removeJob:(BackGroundTaskJob *)job
{
    if ([job isMemberOfClass:[BackGroundTaskJob class]])
    {
        @synchronized (self.jobs) {
            [self.jobs removeObject:job];
        }
    }else if([job isMemberOfClass:[BackGroundTaskTimerJob class]])
    {
        @synchronized (self.timerJobs) {
            [self.timerJobs removeObject:job];
        }
    }
}

- (void)fireJobs
{
    if (!isInBackGround) {
        return;
    }
    dispatch_async(self.queue, ^{
        for (BackGroundTaskJob *job in self.jobs)
        {
            [job done];
        }
        
        @synchronized (self.jobs) {
            [self.jobs removeAllObjects];
        }
    });
}

- (void)fireTimerJobs
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!isInBackGround) {
            return;
        }
        dispatch_async(self.queue, ^{
            for (BackGroundTaskJob *job in self.timerJobs)
            {
                [job done];
            }
        });
    });
}

#pragma mark -
#pragma mark - Notification

- (void)setupNotification
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        self.backgroundTaskId = UIBackgroundTaskInvalid;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    });
}

- (void)appDidEnterBackground
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.backgroundTaskId != UIBackgroundTaskInvalid || !isInBackGround) {
            return;
        }
        
        self.backgroundTaskId =  [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [self destoryBackGroundTask];
        }];
        
        self.backGroundTaskJobsTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
        uint64_t interval = (uint64_t)(1 * NSEC_PER_SEC);
        dispatch_source_set_timer(self.backGroundTaskJobsTimer, start, interval, 0);
        dispatch_source_set_event_handler(self.backGroundTaskJobsTimer, ^{
            [self fireTimerJobs];
        });
        dispatch_resume(self.backGroundTaskJobsTimer);
    });
}

- (void)appWillEnterForeground
{
    [self destoryBackGroundTask];
}

- (void)destoryBackGroundTask
{
    self.backgroundTaskId = UIBackgroundTaskInvalid;
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskId];
}



#pragma mark -
#pragma mark - lazy

- (NSMutableArray *)jobs
{
    if (_jobs == nil) {
        _jobs = [NSMutableArray new];
    }
    return _jobs;
}

- (NSMutableArray *)timerJobs
{
    if (_timerJobs == nil) {
        _timerJobs = [NSMutableArray new];
    }
    return _timerJobs;
}

- (dispatch_queue_t)queue
{
    if (_queue == nil) {
        _queue = dispatch_queue_create("BackGroundTaskJobQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}

@end

#pragma mark -
#pragma mark - BackGroundTaskJob

@interface BackGroundTaskJob ()

@property(nonatomic, copy) BackGroundTaskJobBlock taskJobBlock;

@end

@implementation BackGroundTaskJob

+ (instancetype)jobWithTaskBlock:(BackGroundTaskJobBlock)taskJobBlock
{
    if (!taskJobBlock) {
        return nil;
    }
    
    BackGroundTaskTimerJob *job = [BackGroundTaskTimerJob new];
    job.taskJobBlock = taskJobBlock;
    
    return job;
}


- (void)commit
{
    [[BackGroundTaskManager shareManager] addJob:self];
}

- (void)done
{
    if (self.taskJobBlock) {
        self.taskJobBlock();
    }
}

- (void)cancle
{
    [[BackGroundTaskManager shareManager] removeJob:self];
}

@end

