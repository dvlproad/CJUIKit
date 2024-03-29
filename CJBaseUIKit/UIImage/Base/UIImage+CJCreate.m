//
//  UIImage+CJCreate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJCreate.h"

@implementation UIImage (CJCreate)

#pragma mark - 根据颜色创建图片
/*
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

/*
*  根据渐变颜色创建渐变的图片
*
*  @param colors        图片的渐变颜色
*  @param startPoint    渐变起点
*  @param endPoint      渐变终点
*  @param size          图片大小
*
*  @return 渐变的图片
*/
+ (UIImage *)cj_imageWithGradientColors:(NSArray<UIColor *> *)colors
                     gradientStartPoint:(CGPoint)startPoint
                       gradientEndPoint:(CGPoint)endPoint
                                   size:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero) || colors.count < 2) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    NSMutableArray *array = [NSMutableArray new];
    for (UIColor *color in colors) {
        [array addObject:(__bridge id)color.CGColor];
    }
    
    gradientLayer.colors = array.copy;
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - 将视图转成图片
/*
 *  将视图转成图片
 *
 *  @param contentView      要转成图片的视图
 *  @param opaque           是否是非透明的（NO,半透明效果；YES:透明）
 *
 *  @return 由视图生成的图片
 */
+ (UIImage *)cj_imageWithView:(UIView *)contentView opaque:(BOOL)opaque
{
    UIImage* image = nil;
    CGSize imageSize;
    if ([contentView isKindOfClass:[UIScrollView class]]) {
        imageSize = ((UIScrollView *)contentView).contentSize;
    } else {
        imageSize = contentView.frame.size;
    }
    
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(imageSize, opaque, scale);
    
    
    if ([contentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)contentView;
        
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    } else {
        [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    
    UIGraphicsEndImageContext();

    return image;
}



@end
