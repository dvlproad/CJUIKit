//
//  CJUIKitAlertUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUIKitAlertUtil.h"

@implementation CJUIKitAlertUtil

#pragma mark - UIAlert
/// 显示系统AlertType弹框
+ (void)showInViewController:(UIViewController *)viewController
                   withTitle:(NSString *)title
                     message:(NSString *)message
                 cancleBlock:(void(^)(void))cancleBlock
                     okBlock:(void(^)(void))okBlock
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancleBlock ? cancleBlock():nil;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock ? okBlock():nil;
    }];
    
    NSArray<UIAlertAction *> *alertActions = @[cancelAction, okAction];
    [self __showAlertControllerWithTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleAlert
                            alertActions:(NSArray<UIAlertAction *> *)alertActions
                        inViewController:viewController];
}



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
