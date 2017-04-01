//
//  UIImage+CJChangeColor.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CJChangeColor)

- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)cj_imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
- (UIImage *)cj_imageWithTintColor:(UIColor *)tintColor fraction:(CGFloat)fraction;

@end
