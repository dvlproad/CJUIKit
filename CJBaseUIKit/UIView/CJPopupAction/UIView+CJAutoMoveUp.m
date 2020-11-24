//
//  UIView+CJAutoMoveUp.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJAutoMoveUp.h"
#import <objc/runtime.h>

@interface UIView () {
    
}
@property (nonatomic, assign) CGFloat cjAutoMoveUp__spacing; /**< 视图底部与所弹出来的键盘顶部的间距（默认0） */

@end


@implementation UIView (CJAutoMoveUp)

#pragma mark - runtime
//cjAutoMoveUp__spacing
- (CGFloat)cjAutoMoveUp__spacing {
    return [objc_getAssociatedObject(self, @selector(cjAutoMoveUp__spacing)) integerValue];
}

- (void)setCjAutoMoveUp__spacing:(CGFloat)cjAutoMoveUp__spacing {
    return objc_setAssociatedObject(self, @selector(cjAutoMoveUp__spacing), @(cjAutoMoveUp__spacing), OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark - LifeCycle
- (void)dealloc {
    [self cjAutoMoveUp_unregisterNotification];
}


#pragma mark - Event
/**
 *  自动根据键盘上移
 *  @brief  （请确保此视图的其他地方没有注册键盘通知，否则容易重复，且记得 [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager）
 *
 *  @param shouldAutoMoveUp     是否根据键盘自动上移
 *  @param spacing                          视图底部与所弹出来的键盘顶部的间距（默认0）
 */
- (void)cj_autoMoveUpByKeyboard:(BOOL)shouldAutoMoveUp spacing:(CGFloat)spacing {
    self.cjAutoMoveUp__spacing = spacing;
    
    if (shouldAutoMoveUp) {
        [self cjAutoMoveUp_registerNotification];
    } else {
        [self cjAutoMoveUp_unregisterNotification];
    }
}


#pragma mark - Keyboard Notification
/// 移除通知
- (void)cjAutoMoveUp_unregisterNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

/// 注册通知（请确保此视图的其他地方没有注册键盘通知，否则容易重复，且记得 [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager）
- (void)cjAutoMoveUp_registerNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cjAutoMoveUp_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cjAutoMoveUp_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cjAutoMoveUp_keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}



///键盘显示事件
- (void)cjAutoMoveUp_keyboardWillShow:(NSNotification *)notification {
    
}

///键盘消失事件
- (void)cjAutoMoveUp_keyboardWillHide:(NSNotification *)notification {
    
}

// 键盘弹出会调用
- (void)cjAutoMoveUp_keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    // 获取键盘frame
    //CGRect beginKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    // 获取键盘弹出时长
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];

    // 修改底部视图距离底部的间距
    UIView *popupView = self;
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGFloat popupViewShowY = CGRectGetHeight(keyWindow.frame) - popupViewHeight - edgeInsets.bottom;
    CGFloat newPopupViewShowMaxY = endKeyboardRect.origin.y - self.cjAutoMoveUp__spacing;
    CGFloat newPopupViewShowY = newPopupViewShowMaxY - popupView.frame.size.height;
    
    CGRect new_popupViewShowFrame;
    new_popupViewShowFrame.origin = CGPointMake(popupView.frame.origin.x, newPopupViewShowY);
    new_popupViewShowFrame.size = popupView.frame.size;
    
    // 约束动画
    [UIView animateWithDuration:duration animations:^{
        popupView.frame = new_popupViewShowFrame;
        [popupView layoutIfNeeded];
    }];
}


@end
