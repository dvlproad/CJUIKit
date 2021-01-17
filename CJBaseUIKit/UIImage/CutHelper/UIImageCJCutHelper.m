//
//  UIImageCJCutHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImageCJCutHelper.h"
#import "CJImageTrimmedModel.h"

@implementation UIImageCJCutHelper

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
tooHeightTrimmedHeightKeepWithWithRatio:(CGFloat)tooHeightWidthHeightRatio
{
    CGRect pixelRect =
            [CJImageTrimmedModel getLastPixelRectForImage:image
                                        tooWidthKeepRatio:tooWidthWidthHeightRatio
                                       tooHeightKeepRatio:tooHeightWidthHeightRatio];
    
    UIImage *newImage = [self __cutImage:image inPixelRect:pixelRect];
    
    return newImage;;
}



#pragma mark Private Method
/*
 *  裁剪pixelRect像素区域中的图片
 *
 *  @param image        图片
 *  @param pixelRect    要裁剪的像素区域
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)__cutImage:(UIImage *)image inPixelRect:(CGRect)pixelRect {
//    rect = CGRectMake(0, 0, 100, 100);
//    UIImage *newImage = [self ct_imageFromImage:img inRect:rect];
//    return newImage;
    
    CGImageRef imageRef = image.CGImage;
    //截取中间区域矩形图片
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, pixelRect);
    
    UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    
    UIGraphicsBeginImageContext(pixelRect.size);
    CGRect rectDraw = CGRectMake(0, 0, pixelRect.size.width, pixelRect.size.height);
    [tmp drawInRect:rectDraw];
    // 从当前context中创建一个改变大小后的图片
    tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    NSLog(@"tmp sizewidth is %f sizeHeight is %f",tmp.size.width,tmp.size.height);
    return tmp;
}


#pragma mark - 裁剪图片视图区域
/*
 *  裁剪pixelRect像素区域中的图片
 *
 *  @param image        图片
 *  @param viewRect     要裁剪的视图区域
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(UIImage *)image inViewRect:(CGRect)viewRect {
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = viewRect.origin.x*scale;
    CGFloat y = viewRect.origin.y*scale;
    CGFloat w = viewRect.size.width*scale;
    CGFloat h = viewRect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);

    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:UIImageOrientationUp];
    return newImage;
}



@end
