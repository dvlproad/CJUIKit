//
//  UIImage+CJCreate.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CJCreate)

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
