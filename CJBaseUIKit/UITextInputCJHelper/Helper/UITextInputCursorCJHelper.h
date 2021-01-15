//
//  UITextInputCursorCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  UITextField 和 UITextView 设置光标的方法

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextInputCursorCJHelper : NSObject


#pragma mark - UITextField
#pragma mark UITextField:设置光标
/*
 *  设置文本框的光标位置(无选中的文本)
 *
 *  @param textField    文本框
 *  @param index        光标要放的位置
 */
+ (void)setCursorLocationForTextField:(UITextField *)textField atIndex:(NSInteger)index;

#pragma mark UITextField:设置选中的文本
/*
 *  接受一个范围并选择该范围内的文本（附：如果只想将光标放在某个索引处，则使用长度为0的范围）
 *
 *  @param textField    文本框
 *  @param range        要选择的范围文本(系统用的是UITextRange，这里自己用NSRange结构)
 */
+ (void)selectTextForTextField:(UITextField *)textField atRange:(NSRange)range;

#pragma mark UITextField:获取选中的文本
/*
 *  获取textField中选中的文本的区域
 *
 *  @return textField中选中的文本的区域(系统的是返回UITextRange，这里自己用NSRange结构返回)
 */
+ (NSRange)getSelectedTextRangeForTextField:(UITextField *)textField;




#pragma mark - UITextView
#pragma mark UITextView:设置光标
/*
 *  设置文本框的光标位置(无选中的文本)
 *
 *  @param textView     文本框
 *  @param index        光标要放的位置
 */
+ (void)setCursorLocationForTextView:(UITextView *)textView atIndex:(NSInteger)index;

#pragma mark UITextView:设置选中的文本
/*
 *  接受一个范围并选择该范围内的文本
 *
 *  @param textView     文本框
 *  @param range        要选择的范围文本(如果只想将光标放在某个索引处，则使用长度为0的范围)
 */
+ (void)selectTextForTextView:(UITextView *)textView atRange:(NSRange)range;

#pragma mark UITextView:获取选中的文本
/*
 *  获取textView中选中的文本的区域
 *
 *  @return textView中选中的文本的区域(系统的是返回UITextRange，这里自己用NSRange结构返回)
 */
+ (NSRange)getSelectedTextRangeForTextView:(UITextView *)textView;

@end

NS_ASSUME_NONNULL_END
