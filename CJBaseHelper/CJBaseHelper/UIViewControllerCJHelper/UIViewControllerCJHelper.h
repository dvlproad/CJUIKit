//
//  UIViewControllerCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  源码地址:https://github.com/dvlproad/CJUIKit.git
//
//  场景1：在处理 URL Router 跳转的时候，经常需要得到“当前最上层的视图控制器”来进行视图跳转
//  场景2：如何通过视图(view)获取该视图所在的控制器(viewController)
//  本文简书地址：[iOS 获取当前正在显示的ViewController(最全)](https://www.jianshu.com/p/5013d7bcddb5)
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIViewControllerCJHelper : NSObject

#pragma mark - FindCurrentShowingViewController
///获取Window当前显示的视图控制器ViewController
+ (UIViewController *)findCurrentShowingViewController;

/**
 *  获取Window当前显示的视图控制器ViewController
 *
 *  @param vc   从哪个界面开始分析
 *
 *  @return 当前显示的视图控制器ViewController
 */
+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc;


#pragma mark - FindBelongViewControllerForView
+ (nullable UIViewController *)findBelongViewControllerForView:(UIView *)view;

@end
