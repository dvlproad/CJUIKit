//
//  UIImage+CJCreate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CJCreate)

#pragma mark - 根据颜色创建图片
/*
 *  根据颜色创建图片
 *
 *  @param color 图片颜色
 *  @param size  图片大小
 *
 *  @return 纯色的图片
 */
+ (UIImage *)cj_imageWithColor:(UIColor *)color size:(CGSize)size;

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
                                   size:(CGSize)size;


#pragma mark - 将视图转成图片
/*
 *  将视图转成图片
 *
 *  @param contentView      要转成图片的视图
 *  @param opaque           是否是非透明的（NO,半透明效果；YES:透明）
 *
 *  @return 由视图生成的图片
 */
+ (UIImage *)cj_imageWithView:(UIView *)contentView opaque:(BOOL)opaque;

@end

NS_ASSUME_NONNULL_END
