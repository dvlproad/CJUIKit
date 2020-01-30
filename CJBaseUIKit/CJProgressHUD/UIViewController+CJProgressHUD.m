//
//  UIViewController+CJProgressHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIViewController+CJProgressHUD.h"
#import <objc/runtime.h>
#import "CJProgressHUD.h"
#import "CJToast.h"

@interface UIViewController () {
    
}
@property (nonatomic, strong) CJProgressHUD *cj_progressHUD;


@end

@implementation UIViewController (CJProgressHUD)

//cj_progressHUD
- (CJProgressHUD *)cj_progressHUD {
    return objc_getAssociatedObject(self, @selector(cj_progressHUD));
}

- (void)setCj_progressHUD:(CJProgressHUD *)cj_progressHUD {
    objc_setAssociatedObject(self, @selector(cj_progressHUD), cj_progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 显示HUD
- (void)cj_showProgressHUD {
    if (!self.cj_progressHUD) {
        self.cj_progressHUD = [CJProgressHUD defaultProgressHUD];
    }
    
    [self.cj_progressHUD showInView:self.view withShowBackground:NO];
}

/// 隐藏HUD
- (void)cj_dismissProgressHUD {
    BOOL dismissSuccess = [self.cj_progressHUD dismissWithForce:NO];
    if (dismissSuccess) {
        self.cj_progressHUD = nil;
    }
}

/*
/// 上传过程中显示开始上传的进度提示
- (void)cjdemo_showStartProgressMessage:(NSString * _Nullable)startProgressMessage {
    [self cj_showChrysanthemumHUDWithMessage:startProgressMessage animated:YES];
}

/// 上传过程中显示正在上传的进度提示
- (void)cjdemo_showProgressingMessage:(NSString *)progressingMessage {
    [self cj_updateChrysanthemumHUDWithMessage:progressingMessage];
}

/// 上传过程中显示结束上传的进度提示
- (void)cjdemo_showEndProgressMessage:(NSString *)endProgressMessage isSuccess:(BOOL)isSuccess {
    [self cj_updateChrysanthemumHUDWithMessage:endProgressMessage];
    if (isSuccess) {
        [self cj_hideChrysanthemumHUDWithAnimated:YES afterDelay:0.35];
    } else {
        [self cj_hideChrysanthemumHUDWithAnimated:YES afterDelay:1];
    }
}
*/

@end
