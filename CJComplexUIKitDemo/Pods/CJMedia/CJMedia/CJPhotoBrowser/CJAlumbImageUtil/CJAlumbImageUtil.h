//
//  CJAlumbImageUtil.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/11/10.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///本类中的image用法均来自CJBaseUIKit中的UIImage+CJCategory部分
@interface CJAlumbImageUtil : NSObject

#pragma mark - 来自#import "UIImage+CJFixOrientation.h"
+ (UIImage *)cj_fixOrientation:(UIImage *)image;


#pragma mark - 来自#import "UIImage+CJChangeColor.h"
+ (UIImage *)cj_changeImage:(UIImage *)image withTintColor:(UIColor *)tintColor;


#pragma mark - 来自#import "UIImage+CJTransformSize.h"
/**
 *  把图片按指定的缩放模式裁剪成指定大小的图片(这里缩放模式为不进行缩放、缩小、放大中的"缩小")
 *
 *  @param size         图片要裁剪成的尺寸
 *
 *  @return 修改后的图片
 */
+ (UIImage *)cj_transformImage:(UIImage *)image toMinificationSize:(CGSize)size;//当选择的图片太大时候，就可能会用到这个方法来重新设置大小

@end
