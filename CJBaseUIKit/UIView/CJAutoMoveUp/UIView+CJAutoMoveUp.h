//
//  UIView+CJAutoMoveUp.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//
//  本视图据键盘自动上移的方法

#import <UIKit/UIKit.h>

@interface UIView (CJAutoMoveUp) {
    
}
#pragma mark - Event
/**
 *  自动根据键盘上移
 *  @brief  （请确保此视图的其他地方没有注册键盘通知，否则容易重复，且记得 [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager）
 *
 *  @param shouldAutoMoveUp     是否根据键盘自动上移
 *  @param spacing                          视图底部与所弹出来的键盘顶部的间距（默认0）
 */
- (void)cj_autoMoveUpByKeyboard:(BOOL)shouldAutoMoveUp spacing:(CGFloat)spacing;

@end
