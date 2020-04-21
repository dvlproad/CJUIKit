//
//  UIView+CQProgressHUD.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIView+CQProgressHUD.h"
#import <objc/runtime.h>
#import <CJBaseOverlayKit/UIView+CJSelfProgressHUD.h>
#import <CJBaseOverlayKit/UIView+CJChrysanthemumHUD.h>

#import "CQOverlayTheme.h"
#import "CQHUDUtil.h"

@interface UIView () {
    
}

@end

@implementation UIView (CQProgressHUD)

/// 显示view自己的HUD
- (void)cq_showSelfLoadingHUD {
    if (self.cjSelfProgressHUD) {
        return;
    }
    CQLoadingHUD *selfHud = [CQHUDUtil defaultLoadingHUD];
    [selfHud play];
    [self cj_addSlefProgressHUD:selfHud showingStateOperateEnable:NO];
}

/// 隐藏view自己的HUD
- (void)cq_dismissSelfLoadingHUD {
    if (self.cjSelfProgressHUD) {
        [(CQLoadingHUD *)self.cjSelfProgressHUD stop];
        [self cj_removeSelfProgressHUD];
    }
}

/// 上传过程中显示开始上传的进度提示
- (void)cq_showStartProgressMessage:(NSString * _Nullable)startProgressMessage {
    [self cj_showChrysanthemumHUDWithMessage:startProgressMessage animated:YES];
}

/// 上传过程中显示正在上传的进度提示
- (void)cq_showProgressingMessage:(NSString *)progressingMessage {
    [self cj_updateChrysanthemumHUDWithMessage:progressingMessage];
}

/// 上传过程中显示结束上传的进度提示
- (void)cq_showEndProgressMessage:(NSString *)endProgressMessage isSuccess:(BOOL)isSuccess {
    [self cj_updateChrysanthemumHUDWithMessage:endProgressMessage];
    if (isSuccess) {
        [self cj_hideChrysanthemumHUDWithAnimated:YES afterDelay:0.35];
    } else {
        [self cj_hideChrysanthemumHUDWithAnimated:YES afterDelay:1];
    }
}

@end
