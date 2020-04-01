//
//  UIImage+CJCreate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJCreate.h"

@implementation UIImage (CJCreate)

/**
*  根据颜色创建图片
*
*  @param color 图片颜色
*  @param size  图片大小
*
*  @return 纯色的图片
*/
+ (UIImage *)cj_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
