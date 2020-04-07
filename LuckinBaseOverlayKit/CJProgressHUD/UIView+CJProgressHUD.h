//
//  UIView+CJProgressHUD.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJProgressHUD)

/*
*  显示HUD
*
*  @param animationNamed    HUD的动画使用的json文件名
*  @param showBackground    YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作
*/
- (void)cj_showProgressHUDWithAnimationNamed:(NSString *)animationNamed showBackground:(BOOL)showBackground;

/// 隐藏HUD
- (void)cj_dismissProgressHUD;

@end

NS_ASSUME_NONNULL_END
