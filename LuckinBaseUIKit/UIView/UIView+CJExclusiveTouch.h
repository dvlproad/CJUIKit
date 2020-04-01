//
//  UIView+CJExclusiveTouch.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  其他参考:[同时点击手势深度优化处理 setExclusiveTouch](http://blog.csdn.net/u011363981/article/details/73294499)

#import <UIKit/UIKit.h>

@interface UIView (CJExclusiveTouch)

@property (nonatomic, assign) BOOL cjExclusiveTouch; /**< 默认NO */

@end
