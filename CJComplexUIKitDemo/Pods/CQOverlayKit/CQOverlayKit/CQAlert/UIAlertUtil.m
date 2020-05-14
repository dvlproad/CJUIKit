//
//  UIAlertUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIAlertUtil.h"

@implementation UIAlertUtil

#pragma mark - UIAlertController
/// 显示系统AlertType弹框
+ (void)showSystemAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                    alertActions:(NSArray<UIAlertAction *> *)alertActions
                inViewController:(UIViewController *)viewController
{
    [self __showAlertControllerWithTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleAlert
                            alertActions:(NSArray<UIAlertAction *> *)alertActions
                        inViewController:viewController];
}

/// 显示系统SheetType弹框
+ (void)showSystemSheetWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 alertActions:(NSArray<UIAlertAction *> *)alertActions
                             inViewController:(UIViewController *)viewController
{
    [self __showAlertControllerWithTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleActionSheet
                            alertActions:(NSArray<UIAlertAction *> *)alertActions
                        inViewController:viewController];
}

+ (void)__showAlertControllerWithTitle:(NSString *)title
                               message:(NSString *)message
                        preferredStyle:(UIAlertControllerStyle)preferredStyle
                          alertActions:(NSArray<UIAlertAction *> *)alertActions
                      inViewController:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];

    for (UIAlertAction *alertAction in alertActions) {
        [alertController addAction:alertAction];
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}



@end
