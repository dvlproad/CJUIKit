//
//  UIImage+CJCreate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

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
