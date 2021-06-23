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
@property (nonatomic, assign) CGFloat cjAutoMoveUp__spacing;    /**< 视图底部与所弹出来的键盘顶部的间距（默认0） */
@property (nonatomic, assign) CGRect cjAutoMoveUp__originFrame; /**< 键盘弹出前，视图原始位置 */
@property (nonatomic, copy) void(^cjKeyboardWillShowBlock)(CGFloat duration);
@property (nonatomic, copy) void(^cjKeyboardWillHideBlock)(CGFloat duration);
@property (nonatomic, copy) void(^cjKeyboardWillChangeFrameBlock)(CGFloat keyboardHeight, CGFloat keyboardTopY, CGFloat duration);

@end


@implementation UIView (CJAutoMoveUp)

#pragma mark - runtime:block

// cjKeyboardWillShowBlock
- (void (^)(CGFloat duration))cjKeyboardWillShowBlock {
    return objc_getAssociatedObject(self, @selector(cjKeyboardWillShowBlock));
}

- (void)setCjKeyboardWillShowBlock:(void (^)(CGFloat duration))cjKeyboardWillShowBlock {
    objc_setAssociatedObject(self, @selector(cjKeyboardWillShowBlock), cjKeyboardWillShowBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// cjKeyboardWillHideBlock
- (void (^)(CGFloat duration))cjKeyboardWillHideBlock {
    return objc_getAssociatedObject(self, @selector(cjKeyboardWillHideBlock));
}

- (void)setCjKeyboardWillHideBlock:(void (^)(CGFloat duration))cjKeyboardWillHideBlock {
    objc_setAssociatedObject(self, @selector(cjKeyboardWillHideBlock), cjKeyboardWillHideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// cjKeyboardWillChangeFrameBlock
- (void (^)(CGFloat keyboardHeight, CGFloat keyboardTopY, CGFloat duration))cjKeyboardWillChangeFrameBlock {
    return objc_getAssociatedObject(self, @selector(cjKeyboardWillChangeFrameBlock));
}

- (void)setCjKeyboardWillChangeFrameBlock:(void (^)(CGFloat keyboardHeight, CGFloat keyboardTopY, CGFloat duration))cjKeyboardWillChangeFrameBlock {
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

#pragma mark - runtime:frame
// cjAutoMoveUp__originFrame
- (CGRect)cjAutoMoveUp__originFrame {
    NSString *rectString = objc_getAssociatedObject(self, @selector(cjAutoMoveUp__originFrame));
    return CGRectFromString(rectString);
}

- (void)setCjAutoMoveUp__originFrame:(CGRect)cjAutoMoveUp__originFrame {
    return objc_setAssociatedObject(self, @selector(cjAutoMoveUp__originFrame), NSStringFromCGRect(cjAutoMoveUp__originFrame), OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark - Event
/*
 *  视图添加键盘变化通知监听，自动根据键盘上移
 *  @brief  （请确保此视图的其他地方没有注册键盘通知，否则容易重复，且记得 [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager）
 *
 *  @param spacing                      键盘弹出时候，视图底部与所弹出来的键盘顶部的间距（默认0）
 *  @param hasSpacing                   键盘未弹出时候，视图底部与屏幕边缘是否有间距（如果有则需要回到原来的位置，也就要求执行此方法的时候要求此视图的frame必须有值）
 */
- (void)cj_registerKeyboardNotificationWithAutoMoveUpSpacing:(CGFloat)spacing hasSpacing:(BOOL)hasSpacing {
    if (hasSpacing && CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        NSAssert(NO, @"此时弹出前的视图frame未获得，会导致键盘收起的时候无法回到原来的位置。故请在视图frame加载出来的时候再执行此方法，如vc的viewDidLayoutSubviews或者view的layoutSubviews");
        return;
    }
    self.cjAutoMoveUp__originFrame = self.frame;
    self.cjAutoMoveUp__spacing = spacing;
    
    UIView *popupView = self;
    [self cj_registerKeyboardNotificationWithWillShowBlock:^(CGFloat duration) {
        //NSLog(@"键盘通知：UIKeyboardWillShowNotification");
    } willHideBlock:^(CGFloat duration) {
        //NSLog(@"键盘通知：UIKeyboardWillHideNotification");
    } willChangeFrameBlock:^(CGFloat keyboardHeight, CGFloat keyboardTopY, CGFloat duration) {
        //NSLog(@"键盘通知：UIKeyboardWillChangeFrameNotification");
        if (hasSpacing && keyboardHeight == 0) {
            [UIView animateWithDuration:duration animations:^{
                popupView.frame = self.cjAutoMoveUp__originFrame;
                [popupView layoutIfNeeded];
            }];
            return;
        }
        
        // 修改底部视图距离底部的间距
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
            //popupView.transform =CGAffineTransformMakeTranslation(0, keyboardHeight);
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
- (void)cj_registerKeyboardNotificationWithWillShowBlock:(void(^ _Nullable)(CGFloat duration))keyboardWillShowBlock
                                           willHideBlock:(void(^ _Nullable)(CGFloat duration))keyboardWillHideBlock
                                    willChangeFrameBlock:(void(^ _Nullable)(CGFloat keyboardHeight, CGFloat keyboardTopY, CGFloat duration))keyboardWillChangeFrameBlock
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
    NSDictionary *userInfo = notification.userInfo;
    // 获取键盘弹出时长
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    !self.cjKeyboardWillShowBlock ?: self.cjKeyboardWillShowBlock(duration);
}

///键盘消失事件
- (void)cjKeyboard_WillHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    // 获取键盘弹出时长
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    !self.cjKeyboardWillHideBlock ?: self.cjKeyboardWillHideBlock(duration);
}

// 键盘弹出会调用
- (void)cjKeyboard_WillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    // 获取键盘frame
    //CGRect beginKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardTopY = endKeyboardRect.origin.y;
    CGFloat keyboardHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardTopY;
    //keyboardHeight = endKeyboardRect.size.height;

    // 获取键盘弹出时长
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];

    !self.cjKeyboardWillChangeFrameBlock ?: self.cjKeyboardWillChangeFrameBlock(keyboardHeight, keyboardTopY, duration);
}


@end
