//
//  CQImageLoaderCut.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  加载原始图片，并进行再加工，得到新图片

#import <UIKit/UIKit.h>
#import "CQImageBusinessEnum.h"
#import "UIImageCQCutHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQImageLoaderCut : NSObject

#pragma mark - 原始图片再加工后的新图片的加载
/*
 *  对指定【网络图片】做指定的处理(缩放或裁剪等）得到新图（会默认通过originImageUrl进行缓存，以防止重复裁剪带来的性能影响）
 *
 *  @param image            要处理(缩放或裁剪等）的图片
 *  @param cutType          要处理(缩放或裁剪等）的方式
 *
 *  @return 处理(缩放或裁剪等）后得到的新图
 */
+ (UIImage *)newImageFromOriginImageUrl:(NSString *)originImageUrl withCutType:(CQImageViewCutType)cutType;

/*
 *  对指定【本地图片】做指定的处理(缩放或裁剪等）得到新图（本地图片的裁剪后新图不用设置缓存）
 *
 *  @param image            要处理(缩放或裁剪等）的图片
 *  @param cutType          要处理(缩放或裁剪等）的方式
 *
 *  @return 处理(缩放或裁剪等）后得到的新图
 */
+ (UIImage *)newImageFromOriginImage:(UIImage *)image withCutType:(CQImageViewCutType)cutType;

@end

NS_ASSUME_NONNULL_END
