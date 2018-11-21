//
//  FindView.m
//  iOSwifi
//
//  Created by Stone on 2018/11/17.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "FindView.h"

@interface FindView(){
    
}
@end

@implementation FindView

#pragma mark - LifeCycle
#pragma mark -

- (id)init {
    self = [super init ];//当前对象self
    if (self !=nil) {
        
    }
    return self;//返回一个已经初始化完毕的对象；
}

- (void)drawRect:(CGRect)rect {
    [self setUI];
}

#pragma mark - Public Method
#pragma mark -

#pragma mark - Private Method
#pragma mark -

- (void)setUI{
    _uiView = [[UIView alloc] init];
    _uiView.backgroundColor = [STUIKit colorC16];
    [self addSubview:_uiView];
    //添加约束
    [self setMas];
}

- (void) setMas{
    [_uiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self);
    }];
}

#pragma mark - IB-Action
#pragma mark -


#pragma mark - Notice
#pragma mark -


#pragma mark - Delegate
#pragma mark -


#pragma mark - lazy load
#pragma mark -

@end
