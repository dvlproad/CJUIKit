//
//  UIImageCJCutHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  图片裁剪

#import <UIKit/UIKit.h>

/// 要从图片的哪个区域开始裁剪
typedef NS_ENUM(NSUInteger, UIImageCutFromRegion) {
    UIImageCutFromRegionCenter = 0,     /**< 从图片的中间开始裁剪 */
//    UIImageCutFromRegionLeftTop,        /**< 从图片的左上开始裁剪 */
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImageCJCutHelper : NSObject


#pragma mark - 裁剪图片像素区域
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

/*
 *  从图片指定区域裁剪指定像素大小newPixelSize的图片
 *
 *  @param image            要进行裁剪的图片
 *  @param fromRegionType   要从图片的哪个区域开始裁剪
 *  @param newPixelSize     要裁剪出的像素大小
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(UIImage *)image
       fromRegionType:(UIImageCutFromRegion)fromRegionType
     withNewPixelSize:(CGSize)newPixelSize;


#pragma mark - 裁剪图片视图区域
/*
 *  裁剪pixelRect像素区域中的图片
 *
 *  @param image        图片
 *  @param viewRect     要裁剪的视图区域
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(UIImage *)image inViewRect:(CGRect)viewRect;


@end

NS_ASSUME_NONNULL_END
