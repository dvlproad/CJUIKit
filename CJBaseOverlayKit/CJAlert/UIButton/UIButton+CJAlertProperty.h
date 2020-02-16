//
//  UIButton+CJAlertProperty.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CJAlertProperty)

/// 使用颜色构建的背景图片
UIImage *cjbaseoverlay_buttonBGImage(UIColor *bgColor);

@property (nonatomic, copy) void (^cjTouchUpInsideBlock)(UIButton *button);   /**< 设置按钮操作的事件 */

@end
