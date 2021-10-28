//
//  UIScrollView+CJKeyboardAvoiding.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/13.
//  Copyright (c) 2013 dvlproad. All rights reserved.
//
//  让点击的文本框视图，不会被键盘遮挡住（滚动视图的底部还是原来的位置，不会根据键盘的出现变化）
//  使用方法：
//  ①在初始化的时候，调用[self cj_registerKeyboardNotifications];
//  ②在dealloc的时候，调用[self cj_unRegisterKeyboardNotifications];

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CJKeyboardAvoiding)

@property (nonatomic, assign) CGFloat cjKeyboardAvoidingOffset;  /**< 当键盘会遮挡时候，文本底部离键盘的距离(默认20) */


- (void)cj_registerKeyboardNotifications;
- (void)cj_unRegisterKeyboardNotifications;

/**
 *  取消弹出键盘
 */
- (void)cj_resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
