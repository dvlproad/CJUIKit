//
//  CJUIKitAlertUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUIKitAlertUtil.h"

@implementation CJUIKitAlertUtil

#pragma mark - Alert
/// 显示系统AlertType弹框（我知道了）
+ (void)showIKnowAlertInViewController:(UIViewController *)viewController
                             withTitle:(NSString *)title
                            iKnowBlock:(void(^)(void))iKnowBlock
{
    UIAlertAction *iKnowAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"我知道了", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        iKnowBlock ? iKnowBlock():nil;
    }];
    
    NSArray<UIAlertAction *> *alertActions = @[iKnowAction];
    [self __showControllerWithTitle:title
                            message:nil
                     preferredStyle:UIAlertControllerStyleAlert
                       alertActions:(NSArray<UIAlertAction *> *)alertActions
                   inViewController:viewController];
}

/// 显示系统AlertType弹框（取消+确认）
+ (void)showCancleOKAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                                  message:(NSString *)message
                              cancleBlock:(void(^)(void))cancleBlock
                                  okBlock:(void(^)(void))okBlock;
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancleBlock ? cancleBlock():nil;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock ? okBlock():nil;
    }];
    
    NSArray<UIAlertAction *> *alertActions = @[cancelAction, okAction];
    [self __showControllerWithTitle:title
                            message:message
                     preferredStyle:UIAlertControllerStyleAlert
                       alertActions:(NSArray<UIAlertAction *> *)alertActions
                   inViewController:viewController];
}


#pragma mark - ActionSheet
/// 显示系统ActionSheet弹框
+ (void)showActionSheetInViewController:(UIViewController *)viewController
                              withTitle:(NSString *)title
                                message:(NSString *)message
                             itemTitles:(NSArray<NSString *> *)itemTitles
                            cancleBlock:(void(^)(void))cancleBlock
                         itemClickBlock:(void(^)(NSInteger index))itemClickBlock
{
    NSMutableArray<UIAlertAction *> *alertActions = [[NSMutableArray alloc] init];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancleBlock ? cancleBlock():nil;
    }];
    [alertActions addObject:cancelAction];
    
    
    NSInteger itemCount = itemTitles.count;
    for (NSInteger i = 0; i < itemCount; i++) {
        UIAlertAction *itemAction = [UIAlertAction actionWithTitle:itemTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            itemClickBlock ? itemClickBlock(i):nil;
        }];
        [alertActions addObject:itemAction];
    }
    
    [self __showControllerWithTitle:title
                            message:message
                     preferredStyle:UIAlertControllerStyleActionSheet
                       alertActions:(NSArray<UIAlertAction *> *)alertActions
                   inViewController:viewController];
}



#pragma mark - UIAlertController
+ (void)__showControllerWithTitle:(NSString *)title
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
