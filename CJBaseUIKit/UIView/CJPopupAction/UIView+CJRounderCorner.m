//
//  UIView+CJRounderCorner.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/8/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CJRounderCorner.h"

@implementation UIView (CJRounderCorner)

- (void)cj_addRounderCornerWithRadius:(CGFloat)radius
                                 size:(CGSize)size
                      backgroundColor:(UIColor *)backgroundColor
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(cxt, backgroundColor.CGColor);   //设置填充颜色
    CGContextSetStrokeColorWithColor(cxt, borderColor.CGColor);   //描边颜色
    
    CGContextMoveToPoint(cxt, size.width, size.height-radius);
    CGContextAddArcToPoint(cxt, size.width, size.height, size.width-radius, size.height, radius);//右下角
    CGContextAddArcToPoint(cxt, 0, size.height, 0, size.height-radius, radius);//左下角
    CGContextAddArcToPoint(cxt, 0, 0, radius, 0, radius);//左上角
    CGContextAddArcToPoint(cxt, size.width, 0, size.width, radius, radius);//右上角
    CGContextClosePath(cxt);
    CGContextDrawPath(cxt, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    [self insertSubview:imageView atIndex:0];
}

@end
