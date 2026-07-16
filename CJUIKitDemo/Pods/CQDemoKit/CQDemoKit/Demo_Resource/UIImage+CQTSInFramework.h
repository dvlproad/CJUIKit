//
//  UIImage+CQTSInFramework.h
//  CQDemoKit
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  InFramework中的操作(获取resourceBundle等)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 没使用 use_frameworks! 时候，资源的获取方式
@interface UIImage (CQTSInFramework)

// 不进行缓存，仅限获取 非xcasset内 的图片
+ (nullable UIImage *)cqts_noCache_imageNamed:(nullable NSString *)name
                                     inBundle:(nullable NSBundle *)imageBundle;

@end




#pragma mark - 使用 use_frameworks! 时候，资源的获取方式

@interface NSBundle (CQTSInFramework)

+ (nullable NSBundle *)cqts_framework_resourceBundle:(NSString *)bundleName
                                         ocClassName:(NSString *)ocClassName;

@end

NS_ASSUME_NONNULL_END
