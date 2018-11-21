//
//  FindView.h
//  iOSwifi
//
//  Created by Stone on 2018/11/17.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FindViewDelegate
@optional

//声明代理方法
- (void)toOperate;

@end

@interface FindView : UIView{
}

@property (nonatomic ,weak)id<FindViewDelegate> delegate;

@property (nonatomic ,strong)UIView *uiView;

@end

