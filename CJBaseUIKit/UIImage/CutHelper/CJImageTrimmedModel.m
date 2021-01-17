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
 *  @param image                        图片
 *  @param tooWidthWidthHeightRatio     宽太长时候，裁剪宽，保持高，裁剪后的图片比例
 *  @param tooHeightWidthHeightRatio    高太高时候，裁剪高，保持宽，裁剪后的图片比例
 *
 *  @return 裁剪后的新图
 */
+ (CGRect)getLastPixelRectForImage:(nullable UIImage *)image
                 tooWidthKeepRatio:(CGFloat)tooWidthWidthHeightRatio
                tooHeightKeepRatio:(CGFloat)tooHeightWidthHeightRatio
{
    CJImageTrimmedModel *ratioModel =
            [CJImageTrimmedModel __trimmedModelForImage:image
                tooWidthTrimmedWidthKeepHeightWithRatio:tooWidthWidthHeightRatio
                tooHeightTrimmedHeightKeepWithWithRatio:tooHeightWidthHeightRatio];
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
 *  @param image                        图片
 *  @param tooWidthWidthHeightRatio     宽太长时候，裁剪宽，保持高，裁剪后的图片比例
 *  @param tooHeightWidthHeightRatio    高太高时候，裁剪高，保持宽，裁剪后的图片比例
 *
 *  @return 裁剪后的新图
 */
+ (CJImageTrimmedModel *)__trimmedModelForImage:(nullable UIImage *)image
        tooWidthTrimmedWidthKeepHeightWithRatio:(CGFloat)tooWidthWidthHeightRatio
        tooHeightTrimmedHeightKeepWithWithRatio:(CGFloat)tooHeightWidthHeightRatio
{
    if (image == nil) { // 容错
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
    if (imageRatio > tooWidthWidthHeightRatio) {    // 宽太宽，超出比例，保持高，裁剪宽
        viewWidthHeightRatio = tooWidthWidthHeightRatio;
        trimmedEdge = CJTrimmedEdgeWidth;
        newHeight = oldImageHeight;
        newWidth = newHeight*viewWidthHeightRatio;
    } else {
        if (imageRatio < tooHeightWidthHeightRatio) {
            viewWidthHeightRatio = tooHeightWidthHeightRatio;
            trimmedEdge = CJTrimmedEdgeHeight;
            newWidth = oldImageWidth;
            newHeight = newWidth/viewWidthHeightRatio;
        } else {
            viewWidthHeightRatio = imageRatio;
            trimmedEdge = CJTrimmedEdgeNone;
            newWidth = oldImageWidth;
            newHeight = oldImageHeight;
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
