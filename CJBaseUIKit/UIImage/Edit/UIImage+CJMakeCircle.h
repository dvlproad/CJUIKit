//
//  UIImage+CJMakeCircle.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15-1-30.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CJMakeCircle)

- (UIImage *)cj_makeCircleWithParam:(CGFloat)inset;

/**
 *  将图片弄成圆形
 */
- (UIImage *)cj_circleImage;

@end
