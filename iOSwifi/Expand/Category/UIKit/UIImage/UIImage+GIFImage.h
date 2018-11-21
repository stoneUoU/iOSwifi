//
//  UIImage+GIFImage.h
//  iOSwifi
//
//  Created by Stone on 2018/11/17.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^GIFimageBlock)(UIImage *GIFImage);
@interface UIImage (GIFImage)

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data scaledToSize:(CGSize)newSize;

@end

NS_ASSUME_NONNULL_END
