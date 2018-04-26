//
//  CJAlert.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAlert.h"

#import "CJAlertView.h"

@implementation CJAlert

#pragma mark - UIAlertController
/* 完整的描述请参见文件头部 */
+ (void)showAlertTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                            alertActionModels:(NSArray<CJAlertActionModel *> *)alertActionModels
                             inViewController:(UIViewController *)viewController
{
    [self showAlertControllerWithTitle:title
                               message:message
                        preferredStyle:UIAlertControllerStyleAlert
                     alertActionModels:alertActionModels
                      inViewController:viewController];
}

/* 完整的描述请参见文件头部 */
+ (void)showSheetTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                            alertActionModels:(NSArray<CJAlertActionModel *> *)alertActionModels
                             inViewController:(UIViewController *)viewController
{
    [self showAlertControllerWithTitle:title
                               message:message
                        preferredStyle:UIAlertControllerStyleActionSheet
                     alertActionModels:alertActionModels
                      inViewController:viewController];
}

+ (void)showAlertControllerWithTitle:(NSString *)title
                             message:(NSString *)message
                      preferredStyle:(UIAlertControllerStyle)preferredStyle
                   alertActionModels:(NSArray<CJAlertActionModel *> *)alertActionModels
                    inViewController:(UIViewController *)viewController
{
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];

    for (CJAlertActionModel *alertActionModel in alertActionModels) {
        NSString *alertActionTitle = alertActionModel.title;
        UIAlertActionStyle alertActionStyle = alertActionModel.style;
        void (^alertActionHandler)(UIAlertAction *action) = alertActionModel.handler;
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:alertActionTitle
                                                              style:alertActionStyle
                                                            handler:alertActionHandler];
        [alertController addAction:alertAction];
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}




#pragma mark - CJAlertView
+ (void)showCJAlertViewWithSize:(CGSize)size
                      flagImage:(UIImage *)flagImage
                          title:(NSString *)title
                        message:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
                  okButtonTitle:(NSString *)okButtonTitle
                   cancelHandle:(void(^)(void))cancelHandle
                       okHandle:(void(^)(void))okHandle
{
    CJAlertView *alertView = [CJAlertView alertViewWithSize:size flagImage:flagImage title:title message:message
                                          cancelButtonTitle:cancelButtonTitle
                                              okButtonTitle:okButtonTitle
                                               cancelHandle:cancelHandle
                                                   okHandle:okHandle];
    
    [alertView cj_popupInCenterWindow:CJAnimationTypeNormal
                             withSize:size
                         showComplete:nil tapBlankComplete:nil];
}

@end
