//
//  UIImage+CJTransformSize.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CJScaleType) {
    CJScaleTypeIgnoreOriginRatio = 0,           /**< 放弃原始大小的比例，直接使用现在的大小 */
    CJScaleTypeKeepOriginRatioAndTryLittle,     /**< 保持原始大小的比例，并在缩放后尽量小（宽太宽，裁宽；高太高，裁高） */
    CJScaleTypeKeepOriginRatioAndTryBig         /**< 保持原始大小的比例，并在缩放后尽量大（宽不够，拓宽；高不够，拓高） */
};

@interface UIImage (CJTransformSize)

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
              withScaleType:(CJScaleType)scaleType;

/**
 *  把图片裁剪成指定大小的图片
 *
 *  @param size 图片要裁剪成的尺寸
 *
 *  @return 修改后的图片
 */
- (UIImage *)cj_transformImageToSize:(CGSize)size;
/**
 *  将图片Stretch拉伸处理
 *
 *  @param insets 原始图像要被保护的区域
 *
 *  @return 返回拉伸后的图片
 */
- (UIImage *)cj_resizableImageWithCapInsets:(UIEdgeInsets)insets;



@end

NS_ASSUME_NONNULL_END
