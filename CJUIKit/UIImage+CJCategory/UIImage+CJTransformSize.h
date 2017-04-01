//
//  UIImage+CJTransformSize.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.//

#import <UIKit/UIKit.h>

@interface UIImage (CJTransformSize)

/**
 *  把图片裁剪成指定大小的图片
 *
 *  @param size 图片要裁剪成的尺寸
 *
 *  @return 修改后的图片
 */
- (UIImage *)cj_transformImageToSize:(CGSize)size;


- (UIImage *)cj_resizableImageWithCapInsets:(UIEdgeInsets)insets;


@end
