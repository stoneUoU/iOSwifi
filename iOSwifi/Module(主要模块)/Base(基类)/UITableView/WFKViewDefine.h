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

#endif /* WFKViewDefine_h */



