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
 *  确保图片的宽高比的在什么范围内，如果不在则裁剪。根据设置，先得到等会要如何裁剪image图片像素的裁剪模型数据，并根据得到的该模型进行裁剪其对应的pixelRect像素区域，得到新图片
 *
 *  @param image                        要进行裁剪的图片(不能为nil)
 *  @param fromRegionType               要从图片的哪个区域开始裁剪(一般从中间裁剪)
 *  @param tooWidthWidthHeightRatio     宽高比的最大值/原图宽太宽时候，裁剪宽，保持高，裁剪后的图片比例（不可以为0）
 *  @param tooHeightWidthHeightRatio    宽高比的最小值/原图高太高时候，裁剪高，保持宽，裁剪后的图片比例（不可以为0）
 *  @param noTooWidthOrHeightKeepRatio  不太宽也不太高的时候，裁剪宽或者高二者之一，裁剪后的图片比例（可以为0，且如果为0，则表示使用原图片的比例）
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(nonnull UIImage *)image
       fromRegionType:(UIImageCutFromRegion)fromRegionType
    tooWidthKeepRatio:(CGFloat)tooWidthWidthHeightRatio
   tooHeightKeepRatio:(CGFloat)tooHeightWidthHeightRatio
noTooWidthOrHeightKeepRatio:(CGFloat)noTooWidthOrHeightKeepRatio
{
    // 1、根据设置，获取要等会要如何裁剪image图片像素的裁剪模型数据
    CJImageTrimmedModel *ratioModel =
            [CJImageTrimmedModel trimmedModelForImage:image
              tooWidthTrimmedWidthKeepHeightWithRatio:tooWidthWidthHeightRatio
              tooHeightTrimmedHeightKeepWithWithRatio:tooHeightWidthHeightRatio
                          noTooWidthOrHeightKeepRatio:noTooWidthOrHeightKeepRatio];
    CGFloat newPixelWidth = ratioModel.newWidth;
    CGFloat newPixelHeight = ratioModel.newHeight;
    CGSize newPixelSize = CGSizeMake(newPixelWidth, newPixelHeight);
    
    // 2、根据得到的裁剪模型进行裁剪pixelRect像素区域，得到新图片
    UIImage *newImage = [self cutImage:image
                        fromRegionType:fromRegionType
                      withNewPixelSize:newPixelSize];
    
    return newImage;;
}


/*
 *  从图片指定区域裁剪指定像素大小newPixelSize的图片
 *
 *  @param image            要进行裁剪的图片
 *  @param fromRegionType   要从图片的哪个区域开始裁剪(一般为从图片的中间开始裁剪)
 *  @param newPixelSize     要裁剪出的像素大小(会结合fromRegionType来获取要裁剪的像素区域pixelRect)
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(UIImage *)image
       fromRegionType:(UIImageCutFromRegion)fromRegionType
     withNewPixelSize:(CGSize)newPixelSize
{
    CGRect pixelRect = [self __cutPixelRectForImage:image fromRegionType:fromRegionType withNewPixelSize:newPixelSize];
    
    UIImage *newImage = [self __cutImage:image inPixelRect:pixelRect];
    
    return newImage;
}




#pragma mark Private Method
/*
 *  根据设置，获取等会要如何裁剪image图片像素的裁剪模型数据
 *
 *  @param image            要进行裁剪的图片
 *  @param fromRegionType   要从图片的哪个区域开始裁剪(一般为从图片的中间开始裁剪)
 *  @param newPixelSize     要裁剪出的像素大小
 *
 *  @return 裁剪后的新图
 */
+ (CGRect)__cutPixelRectForImage:(nullable UIImage *)image
                  fromRegionType:(UIImageCutFromRegion)fromRegionType
                withNewPixelSize:(CGSize)newPixelSize
{
    CGFloat newPixelWidth = newPixelSize.width;
    CGFloat newPixelHeight = newPixelSize.height;
    
    CGFloat newPixelX;
    CGFloat newPixelY;
    if (fromRegionType == UIImageCutFromRegionCenter) {
        newPixelX = (image.size.width - newPixelWidth) *0.5;
        newPixelY = (image.size.height - newPixelHeight) *0.5;
    } else {
        newPixelX = (image.size.width - newPixelWidth) *0.5;
        newPixelY = (image.size.height - newPixelHeight) *0.5;
    }
    
    CGRect pixelRect = CGRectMake(newPixelX, newPixelY, newPixelWidth, newPixelHeight);
    
    return pixelRect;
}

/*
 *  裁剪pixelRect像素区域中的图片
 *
 *  @param image        图片
 *  @param pixelRect    要裁剪的像素区域
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)__cutImage:(UIImage *)image inPixelRect:(CGRect)pixelRect {
    CGImageRef imageRef = image.CGImage;
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, pixelRect);// 要裁剪的像素区域pixelRect
    
    UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    
    UIGraphicsBeginImageContext(pixelRect.size);
    CGRect rectDraw = CGRectMake(0, 0, pixelRect.size.width, pixelRect.size.height);//要生成的新图片的像素大小
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
