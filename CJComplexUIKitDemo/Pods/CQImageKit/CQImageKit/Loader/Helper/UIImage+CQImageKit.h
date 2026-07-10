//
//  UIImage+CQImageKit.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CQImageKit)

+ (nullable UIImage *)cqImagekit_imageNamed:(NSString *)name __attribute((deprecated("已废弃，请使用doraemon_xcassetImageNamed")));

+ (nullable UIImage *)cqImagekit_xcassetImageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
