//
//  UIViewController+CJToast.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/19.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIViewController+CJToast.h"
#import <objc/runtime.h>

@interface UIViewController () {
    
}
@property (nonatomic, strong, readonly) MBProgressHUD *cjChrysanthemumHUD;  /**< "菊花HUD" */
//@property (nonatomic, assign, readonly) BOOL isCJChrysanthemumHUDShowing;   /**< 是否"菊花HUD"在显示中 */

@end


@implementation UIViewController (CJToast)

#pragma mark - runtime
- (MBProgressHUD *)cjChrysanthemumHUD {
    MBProgressHUD *hud = objc_getAssociatedObject(self, @selector(cjChrysanthemumHUD));
    if (hud == nil) {
        hud = [[MBProgressHUD alloc] initWithView:self.view];
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
        hud.contentColor = [UIColor whiteColor]; //等待框文字颜色
        hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.76]; //等待框背景色
        hud.removeFromSuperViewOnHide = YES;
        
        objc_setAssociatedObject(self, @selector(cjChrysanthemumHUD), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return hud;
}

/// 显示"菊花HUD"视图
- (void)cj_showChrysanthemumHUDWithMessage:(NSString * _Nullable)startProgressMessage animated:(BOOL)animated {
    if (startProgressMessage) {
        self.cjChrysanthemumHUD.label.text = startProgressMessage;
    }
    [self.view addSubview:self.cjChrysanthemumHUD];
    [self.cjChrysanthemumHUD showAnimated:animated];
}

/// 更新"菊花HUD"文本
- (void)cj_updateChrysanthemumHUDWithMessage:(NSString *)progressingMessage {
    self.cjChrysanthemumHUD.label.text = progressingMessage;
}

/// 隐藏"菊花HUD"视图
- (void)cj_hideChrysanthemumHUDWithAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [self.cjChrysanthemumHUD hideAnimated:animated afterDelay:delay];
}


@end
