//
//  WFKViewDefine.h
//  WIFI
//
//  Created by Stone on 2018/9/21.
//  Copyright © 2018年 Stone. All rights reserved.
//

#ifndef WFKViewDefine_h
#define WFKViewDefine_h

#undef    AS_WFKCUSTOMCELL
#define AS_WFKCUSTOMCELL( __class ) \
+ (__class *)cellWithTableView:(UITableView *)tableView;


#undef    DEF_WFKCUSTOMCELL
#define DEF_WFKCUSTOMCELL( __class ) \
+ (__class *)cellWithTableView:(UITableView *)tableView {\
NSString *cellID = NSStringFromClass([__class class]);\
__class *cell = [tableView dequeueReusableCellWithIdentifier:cellID];\
if (cell == nil) {\
cell = [[__class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];\
}\
return cell;\
}\

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

#endif /* WFKViewDefine_h */



