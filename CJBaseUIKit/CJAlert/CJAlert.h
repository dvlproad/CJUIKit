//
//  CJAlert.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJAlert : NSObject

#pragma mark - UIAlertController
///显示系统AlertType弹框
+ (void)showAlertTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 alertActions:(NSArray<UIAlertAction *> *)alertActions
                             inViewController:(UIViewController *)viewController;

///显示系统SheetType弹框
+ (void)showSheetTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 alertActions:(NSArray<UIAlertAction *> *)alertActions
                             inViewController:(UIViewController *)viewController;


#pragma mark - CJAlertView
/// 显示 title + message + 我知道了
+ (void)showIKnowWithTitle:(NSString *)title message:(NSString *)message okHandle:(void(^)(void))okHandle;

/// 显示 flagImage + title + message + 我知道了
+ (void)showIKnowAlertWithFlagImage:(UIImage *)flagImage title:(NSString *)title message:(NSString *)message okHandle:(void(^)(void))okHandle;

/// 显示 title + 取消 + 确定
+ (void)showCancelOKAlertWithTitle:(NSString *)title okHandle:(void(^)(void))okHandle;

#pragma mark - DebugView
/// 显示app信息
+ (void)showDebugViewWithAppExtraInfo:(NSString *)extraInfo;

///显示调试面板
+ (void)showDebugViewWithTitle:(NSString *)title message:(NSString *)message;

@end
