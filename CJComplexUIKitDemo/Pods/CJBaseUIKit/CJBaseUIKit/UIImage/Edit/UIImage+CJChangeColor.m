//
//  UIImage+CJChangeColor.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJChangeColor.h"

@implementation UIImage (CJChangeColor)

- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor
{
    return [self cj_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)cj_imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self cj_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor fraction:(CGFloat)fraction
{
    if (!tintColor) {
        return self;
    }
    
    // Construct new image the same size as this one.
    UIImage *image;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions([self size], NO, self.scale);
    } else {
        UIGraphicsBeginImageContext([self size]);
    }
#else
    UIGraphicsBeginImageContext([self size]);
#endif
    CGRect rect = CGRectZero;
    rect.size = [self size];
    
    // Composite tint color at its own opacity.
    [tintColor set];
    UIRectFill(rect);
    
    // Mask tint color-swatch to this image's opaque mask.
    // We want behaviour like NSCompositeDestinationIn on Mac OS X.
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    // Finally, composite this image over the tinted mask at desired opacity.
    if (fraction > 0.0) {
        // We want behaviour like NSCompositeSourceOver on Mac OS X.
        [self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
    }
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 改变图标大小
- (UIImage *)cj_resizeToSize:(CGSize)newSize {
    // 创建一个适当大小的位图上下文
    UIGraphicsBeginImageContextWithOptions(newSize, NO, self.scale);
    
    // 将原始图像绘制到新上下文中
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // 从当前上下文中获取修改后的图像
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return resizedImage;
}


// 为图片添加背景色和圆角的方法
- (UIImage *)cj_addBackgroundColor:(UIColor *)backgroundColor
                    backgroundSize:(CGSize)backgroundSize
                         imageSize:(CGSize)imageSize
                      cornerRadius:(CGFloat)cornerRadius
{
    // 如果 backgroundSize 为空，使用图像大小
    if (CGSizeEqualToSize(backgroundSize, CGSizeZero)) {
        backgroundSize = self.size;
    }
    
    // 如果 imageSize 为空，使用图像原始大小
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        imageSize = self.size;
    }
    
    // 创建一个新的图形上下文，使用背景大小
    UIGraphicsBeginImageContextWithOptions(backgroundSize, NO, self.scale);
    
    // 设置圆角路径
    CGRect rect = CGRectMake(0, 0, backgroundSize.width, backgroundSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [path addClip];  // 设置圆角裁剪
    
    // 设置背景色(记得圆角设置要在此之前)
    [backgroundColor setFill];
    UIRectFill(rect);
    
    // 计算图像的位置，确保它居中
    CGRect imageRect = CGRectMake((backgroundSize.width - imageSize.width) / 2,
                                  (backgroundSize.height - imageSize.height) / 2,
                                  imageSize.width,
                                  imageSize.height);
    
    // 绘制原始图片（按照指定的 imageSize 绘制）
    [self drawInRect:imageRect blendMode:kCGBlendModeNormal alpha:1.0];
    
    // 获取添加了背景色、圆角后的图像
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 如果生成失败，返回原图
    return newImage ?: self;
}


@end
