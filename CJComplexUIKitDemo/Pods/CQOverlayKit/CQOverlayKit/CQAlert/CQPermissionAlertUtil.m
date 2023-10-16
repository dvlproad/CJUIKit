//
//  CQPermissionAlertUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQPermissionAlertUtil.h"
#import <CJOverlayView/CJMessageAlertView.h>
//#import <CJOverlayView/CJOverlayView-Swift.h>
#import "UIView+CQPopupOverlayAction.h"

@implementation CQPermissionAlertUtil

#pragma mark - 不支持/无权限弹窗
/*
 *  权限信息的显示或权限弹窗
 *
 *  @param title        title
 *  @param message      message
 *  @param flagImage    flagImage
 */
+ (void)showPermissionAlertWithTitle:(NSString *)title
                             message:(NSString *)message
                           flagImage:(nullable UIImage *)flagImage
{
    NSString *cancelButtonTitle = NSLocalizedString(@"稍后再说", nil);
    NSString *okButtonTitle = NSLocalizedString(@"马上开启", nil);
    
    // 样式1
    CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:nil title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
        [bAlertView cqOverlay_alert_hide];
    } okHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
        [bAlertView cqOverlay_alert_hide];
        cqalert_openSettingCJHelper(nil);   //无权限 引导去开启
    }];
    CGSize popupViewSize = [alertView alertSizeWithShouldAutoFitHeight:YES];
    
    
    // 样式2
//    CQCancelOKImageAlertView *alertView = [[CQCancelOKImageAlertView alloc] init];
//    [alertView configWithTitle:title desText:message flagImage:nil cancelTitle:cancelButtonTitle okTitle:okButtonTitle cancelHandel:^(CQCancelOKImageAlertView * _Nonnull bAlertView) {
//        [bAlertView cqOverlay_alert_hide];
//    } okHandel:^(CQCancelOKImageAlertView * _Nonnull bAlertView) {
//        [bAlertView cqOverlay_alert_hide];
//        cqalert_openSettingCJHelper(nil);   //无权限 引导去开启
//    }];
//    CGSize popupViewSize = CGSizeMake(290, 440);
    
    [alertView cqOverlay_alert_showWithSize:popupViewSize tapBlankShouldHide:NO];
}

+ (nullable UIImage *)cqAlert_imageNamed:(NSString *)name {
    if(name && ![name isEqualToString:@""]) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"CQPermissionAlertUtil")];
        NSURL *url = [bundle URLForResource:@"CQAlert" withExtension:@"bundle"];
        if (url == nil) {
            return nil;
        }
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        UIImage *image = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
        return image;
    }
    
    return nil;
}

/// 跳转到偏好设置页面(C函数)
void cqalert_openSettingCJHelper(void(^completionHandler)(BOOL success)) {
    [CQPermissionAlertUtil openSettingWithCompletionHandler:completionHandler];
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
