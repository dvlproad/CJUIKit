//
//  UIImage+CJChangeColor.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
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

@end
