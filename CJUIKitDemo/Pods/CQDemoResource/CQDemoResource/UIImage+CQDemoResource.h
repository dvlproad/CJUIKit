//
//  UIImage+CQDemoResource.h
//  CQDemoResource
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CQDemoResource)

//+ (nullable UIImage *)cqdemokit_imageNamed:(NSString *)name __attribute((deprecated("已废弃，请使用doraemon_xcassetImageNamed")));

+ (nullable UIImage *)cqresource_imageNamed:(NSString *)name;

// 不进行缓存，仅限获取 非xcasset内 的图片
+ (nullable UIImage *)cqresource_noCache_imageNamed:(NSString *)name;

@end



@interface NSBundle (CQDemoResource)

// 此方法不提供给其他库使用，避免此方法后续修改
+ (nullable NSBundle *)cqdemo_framework_resourceBundle;

@end

NS_ASSUME_NONNULL_END
