//
//  UIViewController+CJToast.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/19.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CJToast)

/// 显示"菊花HUD"视图
- (void)cj_showChrysanthemumHUDWithMessage:(NSString * _Nullable)startProgressMessage animated:(BOOL)animated;

/// 更新"菊花HUD"文本
- (void)cj_updateChrysanthemumHUDWithMessage:(NSString *)progressingMessage;

/// 隐藏"菊花HUD"视图
- (void)cj_hideChrysanthemumHUDWithAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
