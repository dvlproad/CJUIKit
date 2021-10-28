//
//  UIImage+CJTransformSize.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJTransformSize.h"

@implementation UIImage (CJTransformSize)

/*
 *  按指定模式修正大小
 *          @brief 假设原始(100,100),给定size(50,60),那么最终裁剪成的大小有可能
            ①放弃原始大小的比例，直接使用现在的大小(50,60)；
            ②保持原始大小的比例，并在缩放后尽量小（宽太宽，裁宽；高太高，裁高）(50,50)；
            ③保持原始大小的比例，并在缩放后尽量大（宽不够，拓宽；高不够，拓高）(60,60)
 *
 *  @param correctionSize   待修正的大小
 *  @param lastPossibleSize 最后可能的大小(一般直接取图片的image.size，然后乘以比例后的值)
 *  @param scaleType        图片指定的缩放模式
                            ①放弃原始大小的比例，直接使用现在的大小；
                            ②保持原始大小的比例，并在缩放后尽量小（宽太宽，裁宽；高太高，裁高）；
                            ③保持原始大小的比例，并在缩放后尽量大（宽不够，拓宽；高不够，拓高）
 *
 *  @return 修正后的大小
 */
+ (CGSize)cj_correctionSize:(CGSize)correctionSize
         toLastPossibleSize:(CGSize)lastPossibleSize
              withScaleType:(CJScaleType)scaleType
{
    if (scaleType == CJScaleTypeKeepOriginRatioAndTryLittle) {
        CGSize maxSize = [self cj_getMaxSizeInSize:lastPossibleSize withRatioForSize:correctionSize];
        return maxSize;
    } else if (scaleType == CJScaleTypeKeepOriginRatioAndTryBig) {
        CGSize minSize = [self cj_getMinSizeContainSize:lastPossibleSize withRatioForSize:correctionSize];
        return minSize;
    } else {
        return lastPossibleSize;
    }
}


/*
 *  获取在保持指定比例情况下，包含想要的containSize的最小size
 *  @brief 假设给定size(50,60),比例来源(100,100),那么最终的大小为(60,60)：（宽不够，拓宽；高不够，拓高）
 *
 *  @param containSize      要包含的大小（宽不够，拓宽；高不够，拓高）
 *  @param correctionSize   要维持的比例的来源
 *
 *  @return 包含containSize的最小minSize
 */
+ (CGSize)cj_getMinSizeContainSize:(CGSize)containSize withRatioForSize:(CGSize)correctionSize
{
    CGFloat ratioWidth = correctionSize.width/containSize.width;    //宽度需变化的倍数
    CGFloat ratioHeight = correctionSize.height/containSize.height; //高度需变化的倍数
    
    CGFloat minSizeWidth = 0;
    CGFloat minSizeHeight = 0;
    if (ratioWidth < ratioHeight) {
        minSizeWidth = containSize.width;
        minSizeHeight = (containSize.width/correctionSize.width)*correctionSize.height;
    } else {    // 宽变小得更多(可以假设高不变)，让新宽不变小，而是变大
        minSizeWidth = (containSize.height/correctionSize.height)*correctionSize.width;
        minSizeHeight = containSize.height;
    }
    return CGSizeMake(minSizeWidth, minSizeHeight);
}

/*
 *  获取在inSize中保持指定比例情况下的最大size
 *  @brief 假设给定size(50,60),比例来源(100,100),那么最终的大小为(50,50)：（宽太宽，裁宽；高太高，裁高）(50,50)；
 *
 *  @param inSize           在什么大小里寻找（宽太宽，裁宽；高太高，裁高）
 *  @param correctionSize   要维持的比例的来源
 *
 *  @return 在inSize里的最大size
 */
+ (CGSize)cj_getMaxSizeInSize:(CGSize)inSize withRatioForSize:(CGSize)correctionSize {
    CGFloat ratioWidth = correctionSize.width/inSize.width;    //宽度需变化的倍数
    CGFloat ratioHeight = correctionSize.height/inSize.height; //高度需变化的倍数
    
    CGFloat maxSizeWidth = 0;
    CGFloat maxSizeHeight = 0;
    if (ratioWidth > ratioHeight) { // 宽变小得更多(可以假设高不变)，在新宽维持原宽下，让高也变小
        maxSizeWidth = inSize.width;
        maxSizeHeight = (inSize.width/correctionSize.width)*correctionSize.height;
    } else {
        maxSizeWidth = (inSize.height/correctionSize.height)*correctionSize.width;
        maxSizeHeight = inSize.height;
    }
    return CGSizeMake(maxSizeWidth, maxSizeHeight);;
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

@end
