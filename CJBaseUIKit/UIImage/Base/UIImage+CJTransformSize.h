//
//  UIImage+CJTransformSize.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJScaleType) {
    CJScaleTypeNone,                    /**< 不进行缩放 */
    CJScaleTypeAsFarAsPossibleLittle,   /**< 缩放后尽量小 */
    CJScaleTypeAsFarAsPossibleBig       /**< 缩放后尽量大 */
};

@interface UIImage (CJTransformSize)

/**
 *  获取按指定模式执行时候，最后应该得到的大小
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
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *
 *  @return UIImage
 */
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect;

//传入size记得屏幕的1x的size
+ (UIImage *)cutCenterImageSize:(CGSize)size iMg:(UIImage *)img;

/*
 *  裁剪pixelRect像素区域中的图片
 *
 *  @param img img
 *  @param tooWidthWidthHeightRatio     宽太长时候，裁剪宽，保持高，裁剪后的图片比例
 *  @param tooHeightWidthHeightRatio    高太高时候，裁剪高，保持宽，裁剪后的图片比例
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(nullable UIImage *)image
tooWidthTrimmedWidthKeepHeightWithRatio:(CGFloat)tooWidthWidthHeightRatio
tooHeightTrimmedHeightKeepWithWithRatio:(CGFloat)tooHeightWidthHeightRatio;

/**
 *  将图片Stretch拉伸处理
 *
 *  @param insets 原始图像要被保护的区域
 *
 *  @return 返回拉伸后的图片
 */
- (UIImage *)cj_resizableImageWithCapInsets:(UIEdgeInsets)insets;


#pragma mark - compress(图片压缩)
/// 压缩图片(先压缩图片质量，再压缩图片尺寸)
- (NSData *)cj_compressWithMaxDataLength:(NSInteger)maxDataLength;



@end
