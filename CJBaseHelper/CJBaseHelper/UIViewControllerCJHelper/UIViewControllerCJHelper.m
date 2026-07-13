//
//  UIViewControllerCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIViewControllerCJHelper.h"

@implementation UIViewControllerCJHelper

#pragma mark - FindCurrentShowingViewController
/* 完整的描述请参见文件头部 */
+ (UIViewController *)findCurrentShowingViewController {
    //获得当前活动窗口的根视图
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}

//注意考虑几种特殊情况：①A present B, B present C，参数vc为A时候的情况
/* 完整的描述请参见文件头部 */
+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc
{
    //方法1：递归方法 Recursive method
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) { //注要优先判断vc是否有弹出其他视图，如有则当前显示的视图肯定是在那上面
        // 当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }
    
    return currentShowingVC;
    
    /*
    //方法2：遍历方法
    while (1)
    {
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
            
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
            
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
            
        //} else if (vc.childViewControllers.count > 0) {
        //    //如果是普通控制器，找childViewControllers最后一个
        //    vc = [vc.childViewControllers lastObject];
        } else {
            break;
        }
    }
    return vc;
    //*/
}


#pragma mark - FindBelongViewControllerForView
+ (nullable UIViewController *)findBelongViewControllerForView:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

////通过view找到拥有这个View的Controller
//+ (UIViewController *)findBelongViewControllerForView:(UIView *)view
//{
//    for (UIView *next = [view superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
//}


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
    UIViewController *viewController = [self findBelongViewControllerForView:view];
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
