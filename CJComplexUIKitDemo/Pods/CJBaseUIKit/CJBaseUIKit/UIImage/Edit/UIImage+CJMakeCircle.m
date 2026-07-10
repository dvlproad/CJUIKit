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

/**
 *  将图片弄成圆形
 */
- (UIImage *)cj_circleImage {
    // 开始图形上下文，NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();                   // 获得图形上下文
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);  // 设置一个范围
    CGContextAddEllipseInRect(ctx, rect);   // 根据一个rect创建一个椭圆
    CGContextClip(ctx);                     // 裁剪
    [self drawInRect:rect];                 // 将原照片画到图形上下文

    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();            // 关闭上下文

    return newImage;
}


@end
