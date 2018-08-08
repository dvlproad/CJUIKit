//
//  UIViewControllerHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  场景1：在处理 URL Router 跳转的时候，经常需要得到“当前最上层的视图控制器”来进行视图跳转
//  场景2：如何通过视图(view)获取该视图所在的控制器(viewController)
//  知识点：假设从A控制器通过present的方式跳转到了B控制器，那么 A.presentedViewController 就是B控制器；B.presentingViewController 就是A控制器。
//  参考链接：https://blog.csdn.net/leecsdn77/article/details/80662627
//  参考链接2:[如何在多次presentViewController后直接返回最底层界面](https://blog.csdn.net/longshihua/article/details/51282388)

#import <Foundation/Foundation.h>

@interface UIViewControllerHelper : NSObject

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
