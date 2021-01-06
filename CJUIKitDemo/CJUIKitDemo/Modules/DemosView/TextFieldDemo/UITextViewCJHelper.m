//
//  UITextViewCJHelper.m
//  BiaoliApp
//
//  Created by qian on 2020/12/16.
//

#import "UITextViewCJHelper.h"
#import "NSString+CJTextLength.h"

@implementation UITextViewCJHelper

/*
 *  根据最大长度获取shouldChange的时候返回的newText
 *
 *  @param oldText          oldText
 *  @param range            range
 *  @param string           string
 *  @param maxTextLength    maxTextLength(为0的时候不做长度限制)
 *
 *  @return newText
 */
+ (NSString *)shouldChange_newTextFromOldText:(nullable NSString *)oldText shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxTextLength:(NSInteger)maxTextLength
{
    if (oldText == nil) {
        oldText = @"";
    }
    NSString *tempNewText = [oldText stringByReplacingCharactersInRange:range withString:string];//若允许改变，则会改变成的新文本
    tempNewText = [[tempNewText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if (maxTextLength == 0) {
        return tempNewText;
    }
    
    NSInteger oldTextLength = oldText.cj_length;
    if (oldTextLength > maxTextLength) {
        return oldText;
    }
    
    NSInteger tempNewTextLength = tempNewText.cj_length;
    
    NSString *newText;
    if (tempNewTextLength > maxTextLength) {
        NSInteger replacementStringMaxLength = maxTextLength-oldTextLength;
        replacementStringMaxLength = replacementStringMaxLength/2; //暂时以中文处理
        NSString *newReplacementString= [string substringToIndex:replacementStringMaxLength];
        
        NSRange newRange = NSMakeRange(range.location, range.length);
        newText = [oldText stringByReplacingCharactersInRange:newRange withString:newReplacementString];//若允许改变，则会改变成的新文本
    } else {
        newText = tempNewText;
    }
    
    return newText;
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
