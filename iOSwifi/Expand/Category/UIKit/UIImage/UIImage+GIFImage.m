//
//  UIImage+GIFImage.m
//  iOSwifi
//
//  Created by Stone on 2018/11/17.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "UIImage+GIFImage.h"

@implementation UIImage (GIFImage)
+ (UIImage *)imageWithGIFData:(NSData *)data scaledToSize:(CGSize)newSize
{
    if (!data) return nil;
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [self imageWithImageSimple:[[UIImage alloc] initWithData:data] scaledToSize:newSize];
    } else {
        
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            
            // 拿出了Gif的每一帧图片
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            //Learning... 设置动画时长 算出每一帧显示的时长（帧时长）
            NSTimeInterval frameDuration = [UIImage sd_frameDurationAtIndex:i source:source];
            duration += frameDuration;
            
            // 将每帧图片添加到数组中
            [images addObject:[self imageWithImageSimple:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp] scaledToSize:newSize]];
            
            // 释放真图片对象
            CFRelease(image);
        }
        //加快gif的播放速度:
        duration = duration/2;
        // 设置动画时长
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    // 释放源Gif图片
    CFRelease(source);
    
    return animatedImage;
    
}

//缩放图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    [image drawInRect:CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height))];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *newImage = [scaledImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return newImage;
}

+ (UIImage *)GIFName:(NSString *)name scale:(NSUInteger)scale scaledToSize:(CGSize)newSize
{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    
    if (!imagePath) {
        
        (scale + 1 > 3) ? (scale -= 1) : (scale += 1);
        imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    }
    
    if (imagePath) {
        
        // 传入图片名(不包含@Nx)
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        return [UIImage imageWithGIFData:imageData scaledToSize:newSize];
        
    } else {
        
        imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        if (imagePath) {
            
            // 传入的图片名已包含@Nx or 传入图片只有一张 不分@Nx
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            return [UIImage imageWithGIFData:imageData  scaledToSize:newSize];
        } else {
            
            // 不是一张GIF图片(后缀不是gif)
            return [UIImage imageNamed:name];
        }
    }
}

#pragma mark - <关于GIF图片帧时长(Learning...)>

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}
@end
