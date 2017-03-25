//
//  UIImage+CJCreate.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MTUtils)

/**
 *  获取固定size的图片
 *
 *  @param size 图片尺寸
 *
 *  @return 修改后的图片
 */
- (UIImage *)cj_transformImageToSize:(CGSize)size;


- (UIImage *)cj_resizableImageWithCapInsets:(UIEdgeInsets)insets;

/**
 *  根据颜色创建图片
 *
 *  @param color 图片颜色
 *  @param size  图片大小
 *
 *  @return 纯色的图片
 */
+ (UIImage *)cj_imageWithColor:(UIColor *)color size:(CGSize)size;
@end
