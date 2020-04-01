//
//  UIImage+CJTransformSize.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJTransformSize.h"

@implementation UIImage (CJTransformSize)

/**
 *  按指定模式修正大小
 *  @brief 假设原始(100,100),给定size(50,60),那么最终裁剪成的大小有可能有不进行缩放(50,60)、缩放后尽量小(50,50)、缩放后尽量大(60,60)
 *
 *  @param correctionSize   待修正的大小
 *  @param lastPossibleSize 最后可能的大小
 *  @param scaleType        图片指定的缩放模式(不进行缩放、缩放后尽量小、缩放后尽量大)
 *
 *  @return 修正后的大小
 */
+ (CGSize)cj_correctionSize:(CGSize)correctionSize
         toLastPossibleSize:(CGSize)lastPossibleSize
              withScaleType:(CJScaleType)scaleType
{
    switch (scaleType) {
        case CJScaleTypeAsFarAsPossibleLittle:
        {
            // 在保持等比的情况下，修正size的值，使得size尽量小
            CGFloat ratioWidth = correctionSize.width/lastPossibleSize.width;    //宽度需变化的倍数
            CGFloat ratioHeight = correctionSize.height/lastPossibleSize.height; //高度需变化的倍数
            if (ratioWidth > ratioHeight) {
                //lastPossibleSize.width = lastPossibleSize.width;
                lastPossibleSize.height = (lastPossibleSize.width/correctionSize.width)*correctionSize.height;
            } else {
                lastPossibleSize.width = (lastPossibleSize.height/correctionSize.height)*correctionSize.width;
                //lastPossibleSize.height = lastPossibleSize.height;
            }
            
            break;
        }
        case CJScaleTypeAsFarAsPossibleBig:
        {
            // 在保持等比的情况下，修正size的值，使得size尽量大
            CGFloat ratioWidth = correctionSize.width/lastPossibleSize.width;    //宽度需变化的倍数
            CGFloat ratioHeight = correctionSize.height/lastPossibleSize.height; //高度需变化的倍数
            if (ratioWidth < ratioHeight) {
                //lastPossibleSize.width = lastPossibleSize.width;
                lastPossibleSize.height = (lastPossibleSize.width/correctionSize.width)*correctionSize.height;
            } else {
                lastPossibleSize.width = (lastPossibleSize.height/correctionSize.height)*correctionSize.width;
                //lastPossibleSize.height = lastPossibleSize.height;
            }
            break;
        }
        default:
            break;
    }
    return lastPossibleSize;
}

/* 完整的描述请参见文件头部 */
- (UIImage *)cj_transformImageToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //创建一个bitmap的context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];//绘制改变大小的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前context中创建一个改变大小后的图片
    UIGraphicsEndImageContext();    // 使当前的context出堆栈
    
    return newImage;   //返回新的改变大小后的图片
}

/* 完整的描述请参见文件头部 */
- (UIImage *)cj_resizableImageWithCapInsets:(UIEdgeInsets)insets {
    return  [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}


#pragma mark - compress(图片压缩)
/// 压缩图片(先压缩图片质量，再压缩图片尺寸)
- (NSData *)cj_compressWithMaxDataLength:(NSInteger)maxDataLength {
    // Compress by quality
    NSData *data = [self cj_compressQualityWithMaxDataLength:maxDataLength];
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    
    data = [self cj_compressSizeWithMaxDataLength:maxDataLength];
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    
    return data;
}

/**
 *  压缩图片尺寸,直到图片稍小于指定的最大大小(maxDataLength)
 *  @brief 压缩图片尺寸可以使图片小于指定大小，但会使图片明显模糊(比压缩图片质量模糊)
 *
 *  @param maxDataLength 指定的最大大小
 *
 *  @return 图片数据imageData
 */
- (NSData *)cj_compressSizeWithMaxDataLength:(NSInteger)maxDataLength {
    UIImage *resultImage = self;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxDataLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxDataLength / data.length;
        //每次绘制的尺寸 size，要把宽 width 和 高 height 转换为整数，防止绘制出的图片有白边。
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        resultImage = [resultImage cj_transformImageToSize:size];

        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return data;
}

/**
 *  压缩图片质量,直到图片稍小于指定的最大大小(maxDataLength)
 *  @brief 压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；
 缺点在于，不能保证图片压缩后小于指定大小。
 *
 *  @param maxDataLength 指定的最大大小
 *
 *  @return 图片数据imageData
 */
- (NSData *)cj_compressQualityWithMaxDataLength:(NSInteger)maxDataLength {
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
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxDataLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
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
