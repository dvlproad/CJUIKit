//
//  UIImage+CJCreate.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJCreate.h"

@implementation UIImage (MTUtils)

/** 完整的描述请参见文件头部 */
- (UIImage *)cj_transformImageToSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);  //创建一个bitmap的context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];//绘制改变大小的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从当前context中创建一个改变大小后的图片
    UIGraphicsEndImageContext();    // 使当前的context出堆栈
    
    return image;   //返回新的改变大小后的图片
}

/** 完整的描述请参见文件头部 */
- (UIImage *)cj_resizableImageWithCapInsets:(UIEdgeInsets)insets {
    
    return  [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

/** 完整的描述请参见文件头部 */
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
@end
