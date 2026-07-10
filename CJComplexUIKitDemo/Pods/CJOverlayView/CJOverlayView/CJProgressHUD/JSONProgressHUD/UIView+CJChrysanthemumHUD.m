//
//  UIView+CJChrysanthemumHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/19.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CJChrysanthemumHUD.h"
#import <objc/runtime.h>

@interface UIView () {
    
}
@property (nonatomic, strong, readonly) MBProgressHUD *cjChrysanthemumHUD;  /**< "菊花HUD" */

@end


@implementation UIView (CJChrysanthemumHUD)

#pragma mark - runtime
- (MBProgressHUD *)cjChrysanthemumHUD {
    MBProgressHUD *hud = objc_getAssociatedObject(self, @selector(cjChrysanthemumHUD));
    if (hud == nil) {
        hud = [[MBProgressHUD alloc] initWithView:self];
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
    self.cjChrysanthemumHUD.label.numberOfLines = 0;
    
    [self addSubview:self.cjChrysanthemumHUD];
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
