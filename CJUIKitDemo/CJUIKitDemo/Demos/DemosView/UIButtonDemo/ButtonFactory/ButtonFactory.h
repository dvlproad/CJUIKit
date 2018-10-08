//
//  ButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef CJTESTPOD
#import "UIButton+CJMoreProperty.h"
#import "UIColor+CJHex.h"
#import "CJBadgeButton.h"
#else
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import <CJBaseUIKit/CJBadgeButton.h>
#endif

@interface ButtonFactory : NSObject

///蓝色背景按钮
+ (UIButton *)blueButton;

///白色背景按钮
+ (UIButton *)whiteButton;

+ (UIButton *)disableButton;

+ (CJBadgeButton *)defaultBadgeButton;

+ (void)removeObserveForButton:(UIButton *)button;

@end
