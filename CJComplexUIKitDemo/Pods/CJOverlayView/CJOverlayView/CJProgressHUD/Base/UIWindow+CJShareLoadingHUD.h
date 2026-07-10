//
//  UIWindow+CJShareLoadingHUD.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (CJShareLoadingHUD) {
    
}
@property (nullable, nonatomic, strong) UIView *cjShareProgressHUD;    /**< keywindow共享的hud */

/*
*  为本view添加HUD
*
*  @param progressHUD       要给当前view添加的自己的HUD
*  @param showingStateOperateEnable    在hud显示的时候当前view是否可进行其他操作(YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作)
*/
- (void)cj_addShareProgressHUD:(UIView *)progressHUD
     showingStateOperateEnable:(BOOL)showingStateOperateEnable;

/// 移除本view上之前添加的HUD
- (void)cj_removeShareProgressHUD;

@end

NS_ASSUME_NONNULL_END
