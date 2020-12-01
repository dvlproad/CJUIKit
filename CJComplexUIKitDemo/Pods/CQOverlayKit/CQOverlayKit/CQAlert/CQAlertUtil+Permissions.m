//
//  CQAlertUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQAlertUtil.h"

@implementation CQAlertUtil (Permissions)

#pragma mark - 不支持/无权限弹窗
/**
 *  权限信息的显示或权限弹窗
 *
 *  @param title    title
 *  @param message  message
 */
+ (void)showPermissionAlertWithTitle:(NSString *)title
                             message:(NSString *)message
{
    [self showAlertViewWithFlagImage:nil title:title message:message cancelButtonTitle:NSLocalizedString(@"取消", nil) okButtonTitle:NSLocalizedString(@"确定", nil) cancelHandle:nil okHandle:^{
        cqalert_openSettingCJHelper(nil);   //无权限 引导去开启
    }];
}

/// 跳转到偏好设置页面(C函数)
void cqalert_openSettingCJHelper(void(^completionHandler)(BOOL success)) {
    [CQAlertUtil openSettingWithCompletionHandler:completionHandler];
}

/// 跳转到偏好设置页面(OC方法)
+ (void)openSettingWithCompletionHandler:(void(^)(BOOL success))completionHandler {
    NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:completionHandler];
        } else {
            BOOL openSuccess = [[UIApplication sharedApplication] openURL:URL];
            if (completionHandler) {
                completionHandler(openSuccess);
            }
        }
    } else {
        if (completionHandler) {
            completionHandler(NO);
        }
    }
}



@end
