//
//  UITextViewCQHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UITextViewCQHelper.h"
#import "NSString+CJTextLength.h"

@implementation UITextViewCQHelper

/*
 *  根据最大长度获取shouldChange的时候返回的newText
 *
 *  @param oldText              oldText
 *  @param range                range
 *  @param string               string
 *  @param maxTextLength        maxTextLength(为0的时候不做长度限制)
 *
 *  @return newText
 */
+ (UITextInputChangeResultModel *)shouldChange_newTextFromOldText:(nullable NSString *)oldText
                                    shouldChangeCharactersInRange:(NSRange)range
                                                replacementString:(NSString *)string
                                                    maxTextLength:(NSInteger)maxTextLength
{
    UITextInputChangeResultModel *resultModel = [UITextInputCJHelper shouldChange_newTextFromOldText:oldText shouldChangeCharactersInRange:range replacementString:string maxTextLength:maxTextLength lengthCalculationBlock:^NSInteger(NSString * _Nonnull calculationString) {
        NSInteger calculationStringLength = calculationString.cj_length;
        return calculationStringLength;
    }];
    
    return resultModel;
}




#pragma mark - 设置光标
/*
 *  选择文本框光标位置
 *
 *  @param textField    文本框
 *  @param index        光标要放的位置
 */
+ (void)setCursorLocationForTextField:(UITextField *)textField atIndex:(NSInteger)index {
    NSRange range = NSMakeRange(index, 0);
    [self selectTextForTextField:textField atRange:range];
}

/*
 *  接受一个范围并选择该范围内的文本
 *
 *  @param textField    文本框
 *  @param range        要选择的范围文本(如果只想将光标放在某个索引处，则使用长度为0的范围)
 */
+ (void)selectTextForTextField:(UITextField *)textField atRange:(NSRange)range {
    UITextPosition *start = [textField positionFromPosition:[textField beginningOfDocument]
                                                     offset:range.location];
    UITextPosition *end = [textField positionFromPosition:start
                                                   offset:range.length];
    [textField setSelectedTextRange:[textField textRangeFromPosition:start toPosition:end]];
}


/*
 *  根据最大长度获取didChange的时候返回的newText
 *
 *  @param shouldChangeText     shouldChangeText（这是shouldChange种获取的新值）
 *  @param maxTextLength        maxTextLength
 *
 *  @return newText
 */
+ (NSString *)didChange_newTextFromShouldChangeText:(NSString *)shouldChangeText maxTextLength:(NSInteger)maxTextLength {
    // 过滤空格
    NSString *newText = [[shouldChangeText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    
    NSInteger textLength = newText.cj_length;
    if (maxTextLength != 0 && textLength > maxTextLength) { // 有限制，且超多限制，则禁止输入
        maxTextLength = maxTextLength/2; //暂时以中文处理
        newText = [newText substringToIndex:maxTextLength];
    }
    
    return newText;
}

+ (BOOL)textFieldDidChange:(UITextField *)textField maxTextLength:(NSInteger)maxTextLength {
    // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return NO;
    }
    
    // 过滤空格
    NSString *newText = [[textField.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    textField.text = newText;
    
    NSInteger textLength = newText.cj_length;
    if (maxTextLength != 0 && textLength > maxTextLength) { // 有限制，且超多限制，则禁止输入
        newText = [textField.text substringToIndex:maxTextLength];
        textField.text = newText;
    }
    
    return YES;
}


+ (BOOL)textViewDidChange:(UITextView *)textView maxTextLength:(NSInteger)maxTextLength {
    // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
    UITextRange *selectedRange = textView.markedTextRange;
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return NO;
    }
    
    // 过滤空格
    NSString *newText = [[textView.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    textView.text = newText;
    
    NSInteger textLength = newText.cj_length;
    if (maxTextLength != 0 && textLength > maxTextLength) { // 有限制，且超多限制，则禁止输入
        newText = [textView.text substringToIndex:maxTextLength];
        textView.text = newText;
    }
    
    return YES;
}


@end
