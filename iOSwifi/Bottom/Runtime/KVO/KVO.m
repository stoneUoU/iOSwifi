//
//  KVO.m
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "KVO.h"

@interface BB : NSObject

@property (nonatomic,assign) int age;

@end

@implementation BB

@end

@interface KVO ()

@property (nonatomic,strong) BB *B;  /** B **/

@end

@implementation KVO

-(void)dealloc{
    /* 3.移除KVO */
    [_B removeObserver:self forKeyPath:@"age" context:nil];
}

- (instancetype)init
{
    self = [super init ];//当前对象self
    if (self !=nil) {//如果对象初始化成功，才有必要进行接下来的初始化
        _B = [[BB alloc] init];
        [_B addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;//返回一个已经初始化完毕的对象；
}

- (void)kvo {
    
   _B.age = _B.age + 1;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    STLog(@"%@",keyPath);
    STLog(@"%@",object == _B?@"YES":@"NO");
}

@end
