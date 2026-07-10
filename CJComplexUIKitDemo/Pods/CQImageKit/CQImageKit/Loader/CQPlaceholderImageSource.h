//
//  CQPlaceholderImageSource.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  根据图片的使用场景获取指定占位图

#import <UIKit/UIKit.h>
#import "CQImageBusinessEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQPlaceholderImageSource : NSObject


/// 获取指定场景下图片加载前，要使用的占位图
+ (UIImage *)placeholdeImageForImageUseType:(CQImageUseType)imageUseType;

/// 获取指定场景下获取图片被封禁，要使用的违规图片占位图
+ (UIImage *)bannedImageForImageUseType:(CQImageUseType)imageUseType;

/// 获取指定场景下获取图片失败，要使用的错误图片
+ (UIImage *)errorImageForImageUseType:(CQImageUseType)imageUseType;

@end

NS_ASSUME_NONNULL_END
