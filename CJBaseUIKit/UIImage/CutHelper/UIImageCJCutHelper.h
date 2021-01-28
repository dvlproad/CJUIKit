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
 *  根据设置，先得到等会要如何裁剪image图片像素的裁剪模型数据，并根据得到的该模型进行裁剪其对应的pixelRect像素区域，得到新图片
 *
 *  @param image                        要进行裁剪的图片(不能为nil)
 *  @param fromRegionType               要从图片的哪个区域开始裁剪(一般从中间裁剪)
 *  @param tooWidthWidthHeightRatio     宽太宽时候，裁剪宽，保持高，裁剪后的图片比例（不可以为0）
 *  @param tooHeightWidthHeightRatio    高太高时候，裁剪高，保持宽，裁剪后的图片比例（不可以为0）
 *  @param noTooWidthOrHeightKeepRatio  不太宽也不太高的时候，裁剪宽或者高二者之一，裁剪后的图片比例（可以为0，且如果为0，则表示使用原图片的比例）
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(nonnull UIImage *)image
       fromRegionType:(UIImageCutFromRegion)fromRegionType
    tooWidthKeepRatio:(CGFloat)tooWidthWidthHeightRatio
   tooHeightKeepRatio:(CGFloat)tooHeightWidthHeightRatio
noTooWidthOrHeightKeepRatio:(CGFloat)noTooWidthOrHeightKeepRatio;

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
