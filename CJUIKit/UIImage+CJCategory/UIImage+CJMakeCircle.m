//
//  UIImage+CJMakeCircle.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15-1-30.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIImage+CJMakeCircle.h"

@implementation UIImage (CJMakeCircle)

#pragma mark - Image裁剪成圆形的方法
/*
方法1、通过image mask来操作，需要添加mask目标图片。将mask图片直接盖在目标图片上。

方法2、通过imageview的layer来操作(这种方法需要添加QuarztCore框架才能操作)
UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"oiuyfdsa.png"]];
imageView.frame = CGRectMake(20.f, 20.f, 100.f, 100.f);
imageView.layer.masksToBounds = YES;
imageView.layer.cornerRadius = 50;//cornerradus的确定问题


方法3、能过代码对画布裁剪成圆形–》然后再将原始图像画出来–》代码如下：
*/

- (UIImage *)cj_makeCircleWithParam:(CGFloat)inset {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0);//这里设置为0，本来的代码是设置为2，那样会有一些边界
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, self.size.width - inset * 2.0f, self.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [self drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


@end
