//
//  UIImage+CJBase64.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 14-12-26.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CJBase64)

//1.UIImage转成base64
- (NSString *)cj_imageTobase64;

@end

NS_ASSUME_NONNULL_END
