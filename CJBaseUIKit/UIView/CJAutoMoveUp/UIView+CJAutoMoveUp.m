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
@property (nonatomic, copy) void(^cjKeyboardWillShowBlock)(void);
@property (nonatomic, copy) void(^cjKeyboardWillHideBlock)(void);
@property (nonatomic, copy) void(^cjKeyboardWillChangeFrameBlock)(CGFloat keyboardTopY, CGFloat duration);

@end


@implementation UIView (CJAutoMoveUp)

#pragma mark - runtime:block

// cjKeyboardWillShowBlock
- (void (^)(void))cjKeyboardWillShowBlock {
    return objc_getAssociatedObject(self, @selector(cjKeyboardWillShowBlock));
}

- (void)setCjKeyboardWillShowBlock:(void (^)(void))cjKeyboardWillShowBlock {
    objc_setAssociatedObject(self, @selector(cjKeyboardWillShowBlock), cjKeyboardWillShowBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// cjKeyboardWillHideBlock
- (void (^)(void))cjKeyboardWillHideBlock {
    return objc_getAssociatedObject(self, @selector(cjKeyboardWillHideBlock));
}

- (void)setCjKeyboardWillHideBlock:(void (^)(void))cjKeyboardWillHideBlock {
    objc_setAssociatedObject(self, @selector(cjKeyboardWillHideBlock), cjKeyboardWillHideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// cjKeyboardWillChangeFrameBlock
- (void (^)(CGFloat keyboardTopY, CGFloat duration))cjKeyboardWillChangeFrameBlock {
    return objc_getAssociatedObject(self, @selector(cjKeyboardWillChangeFrameBlock));
}

- (void)setCjKeyboardWillChangeFrameBlock:(void (^)(CGFloat keyboardTopY, CGFloat duration))cjKeyboardWillChangeFrameBlock {
    objc_setAssociatedObject(self, @selector(cjKeyboardWillChangeFrameBlock), cjKeyboardWillChangeFrameBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - runtime:normal
//cjAutoMoveUp__spacing
- (CGFloat)cjAutoMoveUp__spacing {
    return [objc_getAssociatedObject(self, @selector(cjAutoMoveUp__spacing)) integerValue];
}

- (void)setCjAutoMoveUp__spacing:(CGFloat)cjAutoMoveUp__spacing {
    return objc_setAssociatedObject(self, @selector(cjAutoMoveUp__spacing), @(cjAutoMoveUp__spacing), OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark - Event
/**
 *  视图添加键盘变化通知监听，自动根据键盘上移
 *  @brief  （请确保此视图的其他地方没有注册键盘通知，否则容易重复，且记得 [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager）
 *
 *  @param spacing                          视图底部与所弹出来的键盘顶部的间距（默认0）
 */
- (void)cj_registerKeyboardNotificationWithAutoMoveUpSpacing:(CGFloat)spacing {
    self.cjAutoMoveUp__spacing = spacing;
    
    [self cj_registerKeyboardNotificationWithWillShowBlock:nil willHideBlock:nil willChangeFrameBlock:^(CGFloat keyboardTopY, CGFloat duration) {
        // 修改底部视图距离底部的间距
        UIView *popupView = self;
    //    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    //    CGFloat popupViewShowY = CGRectGetHeight(keyWindow.frame) - popupViewHeight - edgeInsets.bottom;
        CGFloat newPopupViewShowMaxY = keyboardTopY - self.cjAutoMoveUp__spacing;
        CGFloat newPopupViewShowY = newPopupViewShowMaxY - popupView.frame.size.height;
        
        CGRect new_popupViewShowFrame;
        new_popupViewShowFrame.origin = CGPointMake(popupView.frame.origin.x, newPopupViewShowY);
        new_popupViewShowFrame.size = popupView.frame.size;
        
        // 约束动画
        [UIView animateWithDuration:duration animations:^{
            popupView.frame = new_popupViewShowFrame;
            [popupView layoutIfNeeded];
        }];
    }];
}


#pragma mark - Keyboard Notification
/// 移除视图对键盘变化通知监听
- (void)cj_removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

/*
 *  添加视图对键盘变化的通知监听
 *  @brief  （请确保此视图的其他地方没有注册键盘通知，否则容易重复，且记得 [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager）
 *
 *  @param keyboardWillShowBlock                    键盘将要显示的回调
 *  @param keyboardWillHideBlock                    键盘将要隐藏的回调
 *  @param keyboardWillChangeFrameBlock             键盘大小将要变化的回调
 */
- (void)cj_registerKeyboardNotificationWithWillShowBlock:(void(^ _Nullable)(void))keyboardWillShowBlock
                                           willHideBlock:(void(^ _Nullable)(void))keyboardWillHideBlock
                                    willChangeFrameBlock:(void(^ _Nullable)(CGFloat keyboardTopY, CGFloat duration))keyboardWillChangeFrameBlock
{
    self.cjKeyboardWillShowBlock = keyboardWillShowBlock;
    self.cjKeyboardWillHideBlock = keyboardWillHideBlock;
    self.cjKeyboardWillChangeFrameBlock = keyboardWillChangeFrameBlock;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cjKeyboard_WillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cjKeyboard_WillHide:) name:UIKeyboardWillHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cjKeyboard_WillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


#pragma mark - Notification Action
///键盘显示事件
- (void)cjKeyboard_WillShow:(NSNotification *)notification {
    !self.cjKeyboardWillShowBlock ?: self.cjKeyboardWillShowBlock();
}

///键盘消失事件
- (void)cjKeyboard_WillHide:(NSNotification *)notification {
    !self.cjKeyboardWillHideBlock ?: self.cjKeyboardWillHideBlock();
}

// 键盘弹出会调用
- (void)cjKeyboard_WillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    // 获取键盘frame
    //CGRect beginKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    // 获取键盘弹出时长
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];

    !self.cjKeyboardWillChangeFrameBlock ?: self.cjKeyboardWillChangeFrameBlock(endKeyboardRect.origin.y, duration);
}


@end
