//
//  UIViewCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIViewCJHelper.h"
#import "UIViewControllerCJHelper.h"

@implementation UIViewCJHelper

#pragma mark - 获取指定视图的显示比例
/*
 *  计算指定视图的可见比例
 *
 *  @param view   要判断的视图
 *
 *  @return 视图的显示比例(范围为0.0到1.0)
 */
+ (CGFloat)getVisibleRatioForView:(UIView *)view {
    if (view == nil || view.window == nil) {
        return 0.0;
    }

    // 1. 获取视图在屏幕上的 frame
    CGRect viewFrame = [view convertRect:view.bounds toView:nil];
    CGRect screenBounds = [UIScreen mainScreen].bounds;

    // 2. 计算交集区域
    CGRect intersection = CGRectIntersection(viewFrame, screenBounds);
    if (CGRectIsNull(intersection) || CGRectIsEmpty(intersection)) {
        return 0.0; // 完全不在屏幕上
    }

    // 3. 计算显示比例 (交集面积 / 视图总面积)
    CGFloat viewArea = viewFrame.size.width * viewFrame.size.height;
    CGFloat intersectionArea = intersection.size.width * intersection.size.height;
    
    if (viewArea == 0) return 0.0;
    
    CGFloat visibleRatio = intersectionArea / viewArea;
    
    // 4. 确保视图的 UIViewController 是可见的
    UIViewController *viewController = [UIViewControllerCJHelper findBelongViewControllerForView:view];
    if (!viewController) {
        return 0.0;
    }

    // 如果视图所属的 TabBarController 不是当前选中的 Tab，则不可见
    UITabBarController *tabBarController = viewController.tabBarController;
    if (tabBarController && tabBarController.selectedViewController != viewController.navigationController && tabBarController.selectedViewController != viewController) {
        return 0.0;
    }

    // 如果 NavigationController 不是当前可见控制器，则不可见
    UINavigationController *navController = viewController.navigationController;
    if (navController && navController.visibleViewController != viewController) {
        return 0.0;
    }

    // 如果 ViewController 被 `present` 的 VC 覆盖，则不可见
    if (viewController.presentedViewController) {
        return 0.0;
    }

    return visibleRatio;
}



@end
