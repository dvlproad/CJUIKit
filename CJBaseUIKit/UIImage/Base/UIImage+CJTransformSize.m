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
 *  @param lastPossibleSize 最后可能的大小
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
    switch (scaleType) {
        case CJScaleTypeKeepOriginRatioAndTryLittle:
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
        case CJScaleTypeKeepOriginRatioAndTryBig:
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
