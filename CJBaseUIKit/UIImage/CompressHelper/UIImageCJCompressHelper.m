//
//  UIImageCJCompressHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImageCJCompressHelper.h"

@implementation UIImageCJCompressHelper

#pragma mark - compress(图片压缩)
/// 压缩图片(先压缩图片质量，再压缩图片尺寸)
+ (NSData *)compressImage:(UIImage *)image withMaxDataLength:(NSInteger)maxDataLength {
    // Compress by quality
    NSData *data = [self compressQualityForImage:image withMaxDataLength:maxDataLength];
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    
    data = [self compressQualityForImage:image withMaxDataLength:maxDataLength];
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    
    return data;
}



/*
 *  压缩图片质量,直到图片稍小于指定的最大大小(maxDataLength)
 *  @brief 压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；
 缺点在于，不能保证图片压缩后小于指定大小。
 *
 *  @param image            图片
 *  @param maxDataLength    指定的最大大小
 *
 *  @return 图片数据imageData
 */
+ (NSData *)compressQualityForImage:(UIImage *)image
                  withMaxDataLength:(NSInteger)maxDataLength
{
    /*
    // 方法①:遍历法
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    while (data.length > maxDataLength && compression > 0) {
        compression -= 0.02;
        data = UIImageJPEGRepresentation(self, compression); // When compression less than a value, this code dose not work
    }
    */
    
    // 方法②:二分法
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxDataLength) {
        return data;
    }
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxDataLength * 0.9) {
            min = compression;
        } else if (data.length > maxDataLength) {
            max = compression;
        } else {
            // 当图片大小小于 maxLength，大于 maxLength * 0.9 时，不再继续压缩。
            break;
        }
    }
    
    return data;
}



@end
