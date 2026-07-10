//
//  CJImageTrimmedModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJImageTrimmedModel.h"

@implementation CJImageTrimmedModel

/*
 *  根据设置，获取要等会要如何裁剪image图片像素的裁剪模型数据
 *
 *  @param image                        要裁剪的图片(不能为nil)
 *  @param tooWidthWidthHeightRatio     宽太宽时候，裁剪宽，保持高，裁剪后的图片比例（不可以为0）
 *  @param tooHeightWidthHeightRatio    高太高时候，裁剪高，保持宽，裁剪后的图片比例（不可以为0）
 *  @param noTooWidthOrHeightKeepRatio  不太宽也不太高的时候，裁剪宽或者高二者之一，裁剪后的图片比例（可以为0，且如果为0，则表示使用原图片的比例）
 *
 *  @return 裁剪后的新图
 */
+ (CGRect)getLastPixelRectForImage:(nonnull UIImage *)image
                 tooWidthKeepRatio:(CGFloat)tooWidthWidthHeightRatio
                tooHeightKeepRatio:(CGFloat)tooHeightWidthHeightRatio
       noTooWidthOrHeightKeepRatio:(CGFloat)noTooWidthOrHeightKeepRatio
{
    CJImageTrimmedModel *ratioModel =
            [CJImageTrimmedModel trimmedModelForImage:image
              tooWidthTrimmedWidthKeepHeightWithRatio:tooWidthWidthHeightRatio
              tooHeightTrimmedHeightKeepWithWithRatio:tooHeightWidthHeightRatio
                          noTooWidthOrHeightKeepRatio:noTooWidthOrHeightKeepRatio];
    CGFloat newPixelWidth = ratioModel.newWidth;
    CGFloat newPixelHeight = ratioModel.newHeight;
    
    CGFloat newPixelX = (image.size.width - newPixelWidth) *0.5;
    CGFloat newPixelY = (image.size.height - newPixelHeight) *0.5;
    
    CGRect pixelRect = CGRectMake(newPixelX, newPixelY, newPixelWidth, newPixelHeight);
    
    return pixelRect;
}


/*
 *  根据设置，获取要等会要如何裁剪image图片像素的裁剪模型数据
 *
 *  @param image                        要裁剪的图片(不能为nil)
 *  @param tooWidthWidthHeightRatio     宽太宽时候，裁剪宽，保持高，裁剪后的图片比例（不可以为0）
 *  @param tooHeightWidthHeightRatio    高太高时候，裁剪高，保持宽，裁剪后的图片比例（不可以为0）
 *  @param noTooWidthOrHeightKeepRatio  不太宽也不太高的时候，裁剪宽或者高二者之一，裁剪后的图片比例（可以为0，且如果为0，则表示使用原图片的比例）
 *
 *  @return 裁剪后的新图
 */
+ (CJImageTrimmedModel *)trimmedModelForImage:(nonnull UIImage *)image
      tooWidthTrimmedWidthKeepHeightWithRatio:(CGFloat)tooWidthWidthHeightRatio
      tooHeightTrimmedHeightKeepWithWithRatio:(CGFloat)tooHeightWidthHeightRatio
                  noTooWidthOrHeightKeepRatio:(CGFloat)noTooWidthOrHeightKeepRatio
{
    if (image == nil) {
        return nil;
    }
    
    CGFloat oldImageWidth = image.size.width;
    CGFloat oldImageHeight = image.size.height;
    NSAssert(oldImageWidth != 0 || oldImageHeight != 0, @"图片宽高不可能为0，请检查");
    CGFloat imageRatio = oldImageWidth/oldImageHeight;
    
    
    CGFloat newWidth;
    CGFloat newHeight;
    
    CGFloat viewWidthHeightRatio;
    CJTrimmedEdge trimmedEdge = CJTrimmedEdgeNone;  /**< 要裁剪的边 */
    if (imageRatio > tooWidthWidthHeightRatio) {
        // 宽太宽时候，裁剪宽，保持高（不可以为0）
        viewWidthHeightRatio = tooWidthWidthHeightRatio;
        trimmedEdge = CJTrimmedEdgeWidth;
        newHeight = oldImageHeight;
        newWidth = newHeight*viewWidthHeightRatio;
    } else {
        // 高太高时候，裁剪高，保持宽（不可以为0）
        if (imageRatio < tooHeightWidthHeightRatio) {
            viewWidthHeightRatio = tooHeightWidthHeightRatio;
            trimmedEdge = CJTrimmedEdgeHeight;
            newWidth = oldImageWidth;
            newHeight = newWidth/viewWidthHeightRatio;
        } else {
            // 不太宽也不太高的时候，裁剪宽或者高二者之一（可以为0，且如果为0，则表示使用原图片的比例）
            if (noTooWidthOrHeightKeepRatio != 0) {
                viewWidthHeightRatio = noTooWidthOrHeightKeepRatio;
                if (imageRatio > noTooWidthOrHeightKeepRatio) { //原图比例太宽，希望的是比较小的比例，则裁剪宽
                    trimmedEdge = CJTrimmedEdgeWidth;
                    newHeight = oldImageHeight;
                    newWidth = newHeight*viewWidthHeightRatio;
                } else {                                        //裁剪高
                    trimmedEdge = CJTrimmedEdgeHeight;
                    newWidth = oldImageWidth;
                    newHeight = newWidth/viewWidthHeightRatio;
                }
            } else {    // 不太宽也不太高的时候，如果没指定希望的比例，而是传0，则表示不太宽也不太高的时候使用原图片的比例输出
                viewWidthHeightRatio = imageRatio;
                trimmedEdge = CJTrimmedEdgeNone;
                newWidth = oldImageWidth;
                newHeight = oldImageHeight;
            }
        }
    }
    
    CJImageTrimmedModel *imageTrimmedModel = [[CJImageTrimmedModel alloc] init];
    imageTrimmedModel.hopeNewRatio = viewWidthHeightRatio;
    imageTrimmedModel.trimmedEdge = trimmedEdge;
    imageTrimmedModel.newWidth = newWidth;
    imageTrimmedModel.newHeight = newHeight;
    
    return imageTrimmedModel;
}

@end
