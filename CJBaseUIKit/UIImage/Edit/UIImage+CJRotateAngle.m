//
//  UIImage+CJRotateAngle.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJRotateAngle.h"

@implementation UIImage (CJRotateAngle)

/* 完整的描述请参见文件头部 */
- (UIImage *)cj_rotateImageWithAngle:(CGFloat)angle isExpand:(BOOL)isExpand
{
    CGSize imageSize = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    CGSize outputSize = imageSize;
    if (isExpand) {
        CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height); //旋转
        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(angle*M_PI/180.0));
        outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    }
    UIGraphicsBeginImageContext(outputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context, angle*M_PI/180.0);
    CGContextTranslateCTM(context, -imageSize.width / 2, -imageSize.height / 2);
    
    [self drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
