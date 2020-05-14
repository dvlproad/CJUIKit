//
//  UIAlertUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertUtil : NSObject

#pragma mark - UIAlertController
/// 显示系统AlertType弹框
+ (void)showSystemAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                    alertActions:(NSArray<UIAlertAction *> *)alertActions
                inViewController:(UIViewController *)viewController;

/// 显示系统SheetType弹框
+ (void)showSystemSheetWithTitle:(NSString *)title
                         message:(NSString *)message
                    alertActions:(NSArray<UIAlertAction *> *)alertActions
                inViewController:(UIViewController *)viewController;



@end
