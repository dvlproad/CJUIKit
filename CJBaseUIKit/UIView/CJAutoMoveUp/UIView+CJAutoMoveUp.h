//
//  UIView+CJAutoMoveUp.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//
//  本视图据键盘自动上移的方法（常用于底部弹窗内部有文本框的时候）

#import <UIKit/UIKit.h>

@interface UIView (CJAutoMoveUp) {
    
}
#pragma mark - Event
/*
 *  视图添加键盘变化通知监听，自动根据键盘上移
 *  @brief  （请确保此视图的其他地方没有注册键盘通知，否则容易重复，且记得 [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager）
 *
 *  @param spacing                      键盘弹出时候，视图底部与所弹出来的键盘顶部的间距（默认0）
 *  @param hasSpacing                   键盘未弹出时候，视图底部与屏幕边缘是否有间距（如果有则需要回到原来的位置，也就要求执行此方法的时候要求此视图的frame必须有值）
 */
- (void)cj_registerKeyboardNotificationWithAutoMoveUpSpacing:(CGFloat)spacing hasSpacing:(BOOL)hasSpacing;



#pragma mark - Keyboard Notification
/// 移除视图对键盘变化通知监听
- (void)cj_removeKeyboardNotification;

/*
 *  添加视图对键盘变化的通知监听
 *  @brief  （请确保此视图的其他地方没有注册键盘通知，否则容易重复，且记得 [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager）
 *
 *  @param keyboardWillShowBlock                    键盘将要显示的回调
 *  @param keyboardWillHideBlock                    键盘将要隐藏的回调
 *  @param keyboardWillChangeFrameBlock             键盘大小将要变化的回调
 */
- (void)cj_registerKeyboardNotificationWithWillShowBlock:(void(^ _Nullable)(CGFloat duration))keyboardWillShowBlock
                                           willHideBlock:(void(^ _Nullable)(CGFloat duration))keyboardWillHideBlock
                                    willChangeFrameBlock:(void(^ _Nullable)(CGFloat keyboardHeight, CGFloat keyboardTopY, CGFloat duration))keyboardWillChangeFrameBlock;

@end
