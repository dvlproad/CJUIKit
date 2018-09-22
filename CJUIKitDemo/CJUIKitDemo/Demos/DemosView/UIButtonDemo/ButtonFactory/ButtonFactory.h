//
//  ButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ButtonFactory : NSObject

///蓝色背景按钮
+ (UIButton *)blueButton;

///白色背景按钮
+ (UIButton *)whiteButton;

+ (void)removeObserveForButton:(UIButton *)button;

@end
