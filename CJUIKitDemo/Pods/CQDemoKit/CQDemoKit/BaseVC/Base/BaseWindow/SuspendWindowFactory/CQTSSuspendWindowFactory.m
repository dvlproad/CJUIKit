//
//  CQTSSuspendWindowFactory.m
//  CQDemoKit
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSSuspendWindowFactory.h"
#import "CQTSSuspendWindow.h"
#import "CQTSSuspendButtonRootViewController.h"

@implementation CQTSSuspendWindowFactory

/*
 *  显示按钮样式的悬浮视图
 *
 *  @param buttonTitle              按钮的大小
 *  @param buttonTitle              按钮的标题
 *  @param buttonClickCompleteBlock 点击按钮后执行的动作（已内置执行悬浮视图消失）
 *
 *  @return 悬浮视图
 */
+ (UIWindow *)showSuspendButtonWithSize:(CGSize)size
                                  title:(NSString *)buttonTitle
                      clickCompleteBlock:(void(^ _Nullable)(void))buttonClickCompleteBlock
{
    CQTSSuspendWindow *suspendWindow = [[CQTSSuspendWindow alloc] initWithFrame:CGRectMake(100, 100, size.width, size.height)];
    // 设置 rootViewController
    __weak typeof(suspendWindow)weakSuspendWindow = suspendWindow;
    UIViewController *rootViewController = [[CQTSSuspendButtonRootViewController alloc] initWithButtonTitle:buttonTitle buttonClickHandle:^{
        [weakSuspendWindow removeFromScreen];
        !buttonClickCompleteBlock ?: buttonClickCompleteBlock();
    }];
    suspendWindow.rootViewController = rootViewController;
    
    [suspendWindow makeKeyAndVisible];
    
    return suspendWindow;
}

@end
