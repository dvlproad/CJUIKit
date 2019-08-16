//
//  UIView+CJRounderCorner.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/8/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJRounderCorner)

- (void)cj_addRounderCornerWithRadius:(CGFloat)radius
                                 size:(CGSize)size
                      backgroundColor:(UIColor *)backgroundColor
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
