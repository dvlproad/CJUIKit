//
//  UIView+CQProgressHUD.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CQProgressHUD)

/// 显示view自己的HUD
- (void)cq_showSelfLoadingHUD;

/// 隐藏view自己的HUD
- (void)cq_dismissSelfLoadingHUD;

/// 上传过程中显示开始上传的进度提示
- (void)cq_showStartProgressMessage:(NSString * _Nullable)startProgressMessage;

/// 上传过程中显示正在上传的进度提示
- (void)cq_showProgressingMessage:(NSString *)progressingMessage;

/// 上传过程中显示结束上传的进度提示
- (void)cq_showEndProgressMessage:(NSString *)endProgressMessage isSuccess:(BOOL)isSuccess;

@end

NS_ASSUME_NONNULL_END
