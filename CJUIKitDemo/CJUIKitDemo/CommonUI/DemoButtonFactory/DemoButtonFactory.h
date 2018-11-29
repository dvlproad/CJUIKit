//
//  DemoButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  想两改变两个子控件的显示位置，可以分别通过setTitleEdgeInsets和setImageEdgeInsets来实现。需要注意的是，对titleLabel和imageView设置偏移，是针对它当前的位置起作用的，并不是针对它距离button边框的距离的

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import <CJBaseUIKit/CJBadgeButton.h>

@interface DemoButtonFactory : NSObject

///蓝色背景按钮
+ (UIButton *)blueButton;

///白色背景按钮
+ (UIButton *)whiteButton;

///倒计时按钮
+ (UIButton *)timerButton;

+ (UIButton *)disableButton;

+ (CJBadgeButton *)defaultBadgeButton;

+ (CJBadgeButton *)goDeliverBadgeButton;

+ (void)removeObserveForButton:(UIButton *)button;

@end
