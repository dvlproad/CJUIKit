//
//  UIViewController+CJSystemBackButtonHandler.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/9/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  可参考:
//  ①[获取导航栏返回按钮的点击事件](http://www.jianshu.com/p/90a104ac6633)
//  ②[导航栏返回按钮事件](http://www.jianshu.com/p/25fd027916fa)

#import <UIKit/UIKit.h>

@protocol CJSystemBackButtonHandlerProtocol <NSObject>

@optional
// Override this method in UIViewController derived class to handle 'Back' button click
- (BOOL)cj_navigationShouldPopOnBackButton;

@end




@interface UIViewController (CJSystemBackButtonHandler) <CJSystemBackButtonHandlerProtocol>

@end
