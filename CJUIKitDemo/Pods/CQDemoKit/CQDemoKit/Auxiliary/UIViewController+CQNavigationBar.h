//
//  UIViewController+CQNavigationBar.h
//  CQDemoKit
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  为 present 出来的视图，添加 NavigationBar

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CQNavigationBar)

/// 设置自定义导航栏
- (void)setupNavigationBarColor:(UIColor *)bgColor
                          title:(NSString *)title
                    backButtonTitle:(NSString *)backTitle
//                         backAction:(SEL)backAction
                    backButtonAction:(void (^)(UIButton * _Nonnull))backButtonAction;

@end

NS_ASSUME_NONNULL_END
