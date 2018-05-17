//
//  UIImage+CJBlur.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CJBlur)

- (UIImage *)cj_applyLightEffect;
- (UIImage *)cj_applyExtraLightEffect;
- (UIImage *)cj_applyDarkEffect;
- (UIImage *)cj_applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)cj_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
