//
//  UIView+CJSelfProgressHUD.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJSelfProgressHUD) {
    
}
@property (nullable, nonatomic, strong) UIView *cjSelfProgressHUD;    /**< 当前视图自己的 progressHUD（不是全局的共享hud，自己可在隐藏后被设为nil，共享的不行）*/

/*
*  为本view添加HUD
*
*  @param progressHUD                   要给当前view添加的自己的HUD
*  @param showingStateOperateEnable     在hud显示的时候当前view是否可进行其他操作(YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作)
*/
- (void)cj_addSlefProgressHUD:(UIView *)progressHUD
    showingStateOperateEnable:(BOOL)showingStateOperateEnable;

/// 移除本view上之前添加的HUD
- (void)cj_removeSelfProgressHUD;

@end

NS_ASSUME_NONNULL_END
