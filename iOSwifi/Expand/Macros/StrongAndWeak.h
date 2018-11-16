//
//  StrongAndWeak.h
//  iOSwifi
//
//  Created by Stone on 2018/11/15.
//  Copyright © 2018 Stone. All rights reserved.
//

//定义weakify
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongdify
#if __has_feature(objc_arc)
#define strongdify(object) ext_keywordify __strong __typeof__(object) object = weak##_##object;
#else
#define strongdify(object)                                                                    \
ext_keywordify __strong __typeof__(object) object = block##_##object;
#endif
#endif
