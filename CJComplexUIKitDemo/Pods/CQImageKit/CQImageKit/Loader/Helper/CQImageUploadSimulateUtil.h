//
//  CQImageUploadSimulateUtil.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQImageUploadSimulateUtil : NSObject

// 图片转字符串（图片上传使用模拟的时候，需要使用此方法来获取图片url）
+ (NSString *)__localSimulateImageUrlFromImage:(UIImage *)image;

// 字符串转图片(图片上传使用模拟的时候，需要用此方法获取对应的图片)
+ (UIImage *)imageFromLocalSimulateImageUrl:(NSString *)encodedImageString;

@end

NS_ASSUME_NONNULL_END
