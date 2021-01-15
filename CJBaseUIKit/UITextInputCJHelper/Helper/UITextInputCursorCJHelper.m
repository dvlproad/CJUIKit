//
//  UITextInputCursorCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UITextInputCursorCJHelper.h"

@implementation UITextInputCursorCJHelper


#pragma mark - UITextField
#pragma mark UITextField:设置光标
/*
 *  设置文本框的光标位置(无选中的文本)
 *
 *  @param textField    文本框
 *  @param index        光标要放的位置
 */
+ (void)setCursorLocationForTextField:(UITextField *)textField atIndex:(NSInteger)index {
    NSRange range = NSMakeRange(index, 0);
    [self selectTextForTextField:textField atRange:range];
}


#pragma mark UITextField:设置选中的文本
/*
 *  接受一个范围并选择该范围内的文本（附：如果只想将光标放在某个索引处，则使用长度为0的范围）
 *
 *  @param textField    文本框
 *  @param range        要选择的范围文本(系统用的是UITextRange，这里自己用NSRange结构)
 */
+ (void)selectTextForTextField:(UITextField *)textField atRange:(NSRange)range {
    UITextPosition *beginningPosition = [textField beginningOfDocument];
    
    UITextPosition *startPosition = [textField positionFromPosition:beginningPosition offset:range.location];
    UITextPosition *endPosition   = [textField positionFromPosition:startPosition offset:range.length];
    //UITextPosition *endPosition   = [textField positionFromPosition:beginningPosition offset:range.location + range.length];
    
    UITextRange *textRange = [textField textRangeFromPosition:startPosition toPosition:endPosition];
    [textField setSelectedTextRange:textRange];
}


#pragma mark UITextField:获取选中的文本
/*
 *  获取textField中选中的文本的区域
 *
 *  @return textField中选中的文本的区域(系统的是返回UITextRange，这里自己用NSRange结构返回)
 */
+ (NSRange)getSelectedTextRangeForTextField:(UITextField *)textField {
    UITextPosition *beginning = textField.beginningOfDocument;
    
    UITextRange *selectedRange = textField.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length   = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}






#pragma mark - UITextView
#pragma mark UITextView:设置光标
/*
 *  设置文本框的光标位置(无选中的文本)
 *
 *  @param textView     文本框
 *  @param index        光标要放的位置
 */
+ (void)setCursorLocationForTextView:(UITextView *)textView atIndex:(NSInteger)index {
    NSRange range = NSMakeRange(index, 0);
    [self selectTextForTextView:textView atRange:range];
}

#pragma mark UITextView:设置选中的文本
/*
 *  接受一个范围并选择该范围内的文本
 *
 *  @param textView     文本框
 *  @param range        要选择的范围文本(如果只想将光标放在某个索引处，则使用长度为0的范围)
 */
+ (void)selectTextForTextView:(UITextView *)textView atRange:(NSRange)range {
    UITextPosition *start = [textView positionFromPosition:[textView beginningOfDocument]
                                                     offset:range.location];
    UITextPosition *end = [textView positionFromPosition:start
                                                   offset:range.length];
    [textView setSelectedTextRange:[textView textRangeFromPosition:start toPosition:end]];
}

#pragma mark UITextView:获取选中的文本
/*
 *  获取textView中选中的文本的区域
 *
 *  @return textView中选中的文本的区域(系统的是返回UITextRange，这里自己用NSRange结构返回)
 */
+ (NSRange)getSelectedTextRangeForTextView:(UITextView *)textView {
    UITextPosition *beginning = textView.beginningOfDocument;
    
    UITextRange *selectedRange = textView.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [textView offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length   = [textView offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}


@end
