//
//  Person+AttrAdd.h
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (AttrAdd)

// 分类中声明属性，只会生成setter和getter方法的声明，不会生成带“_”的成员变量和setter和getter方法的实现
@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *strName;

@end

NS_ASSUME_NONNULL_END
