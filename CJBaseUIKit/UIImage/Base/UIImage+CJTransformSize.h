//
//  UIImage+CJTransformSize.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJScaleType) {
    CJScaleTypeNone,            /**< 不进行任何缩放 */
    CJScaleTypeMinification,    /**< 缩小率 */
    CJScaleTypeAmplification    /**< 放大率 */
};

@interface UIImage (CJTransformSize)

/**
 *  把图片按指定的缩放模式裁剪成指定大小的图片
 *
 *  @param size         图片要裁剪成的尺寸
 *  @param scaleType    图片指定的缩放模式(不进行缩放、缩小、放大)
 *
 *  @return 修改后的图片
 */
- (UIImage *)cj_transformImageToSize:(CGSize)size withScaleType:(CJScaleType)scaleType;

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
