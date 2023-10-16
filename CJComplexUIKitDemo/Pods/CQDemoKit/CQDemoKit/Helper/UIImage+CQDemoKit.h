//
//  UIImage+CQDemoKit.h
//  TSDemoDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CQDemoKit)

+ (nullable UIImage *)cqdemokit_imageNamed:(NSString *)name __attribute((deprecated("已废弃，请使用doraemon_xcassetImageNamed")));

+ (nullable UIImage *)cqdemokit_xcassetImageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
