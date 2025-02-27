//
//  UIImage+CJChangeColor.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CJChangeColor)

- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)cj_imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor fraction:(CGFloat)fraction;

// 改变图标大小
- (UIImage *)cj_resizeToSize:(CGSize)newSize;

// 为图片添加背景色和圆角的方法
- (UIImage *)cj_addBackgroundColor:(UIColor *)backgroundColor
                    backgroundSize:(CGSize)backgroundSize
                         imageSize:(CGSize)imageSize
                      cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
