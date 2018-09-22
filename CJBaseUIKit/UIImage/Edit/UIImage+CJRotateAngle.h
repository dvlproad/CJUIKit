//
//  UIImage+CJRotateAngle.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CJRotateAngle)

/**
 *  将图片旋转指定角度后得到新的图片
 *
 *  @param angle    要旋转的角度
 *  @param isExpand 是否扩展,如果不扩展,那么图像大小不变,但被截掉一部分
 *
 *  @return 旋转后的图片
 */
- (UIImage *)cj_rotateImageWithAngle:(CGFloat)angle isExpand:(BOOL)isExpand;

@end
