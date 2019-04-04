//
//  UITextField+CJForbidKeyboard.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//  一个文本框中的文本禁止通过键盘手动输入的时候，即禁止键盘的时候，首先肯定需要①隐藏光标，其次一般②最多允许弹出选择、复制操作

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (CJForbidKeyboard) {
    
}

/**
 *  禁用文本框的输入，同时设置文本框的文本来源可为textPicker
 *
 *  @param textPicker 文本框的文本来源,其将作为文本框的inputView使用
 */
- (void)cj_forbidKeyboardAndTextPicker:(UIView * _Nullable)textPicker;

@end

NS_ASSUME_NONNULL_END
