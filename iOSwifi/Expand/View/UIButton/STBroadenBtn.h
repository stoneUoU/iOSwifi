//
//  STBroadenBtn.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STBroadenBtn : UIButton

@property (nonatomic,assign) CGFloat minimumHitTestWidth;

@property (nonatomic,assign) CGFloat minimumHitTestHeight;

@property (nonatomic,assign) UIEdgeInsets hitTestEdgeInsets;

@end

NS_ASSUME_NONNULL_END
