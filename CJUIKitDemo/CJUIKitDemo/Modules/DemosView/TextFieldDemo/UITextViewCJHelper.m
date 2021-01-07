//
//  UITextViewCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UITextViewCJHelper.h"
#import "NSString+CJTextLength.h"

@implementation UITextViewCJHelper

/*
 *  根据最大长度获取shouldChange的时候返回的newText
 *
 *  @param oldText              oldText
 *  @param range                range
 *  @param string               string
 *  @param maxTextLength        maxTextLength(为0的时候不做长度限制)
 *  @param lastSelectedText     上一次没有未选中/没有高亮文本时候的文本
 *
 *  @return newText
 */
+ (CQTextInputChangeResultModel *)shouldChange_newTextFromOldText:(nullable NSString *)oldText
                shouldChangeCharactersInRange:(NSRange)range
                            replacementString:(NSString *)string
                                maxTextLength:(NSInteger)maxTextLength
                             lastSelectedText:(nullable NSString *)lastSelectedText
{
    CQTextInputChangeResultModel *resultModel = [[CQTextInputChangeResultModel alloc] initWithOriginReplacementString:string];
    if (oldText == nil) {
        oldText = @"";
    }
    BOOL isDifferentFromSystemDeal = NO;
    NSString *hopeReplacementString = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if ([hopeReplacementString isEqualToString:string] == NO) { // 系统处理是允许输入空格的
        isDifferentFromSystemDeal = YES;
    }
    
    NSString *tempNewText = [oldText stringByReplacingCharactersInRange:range withString:hopeReplacementString];//若不做任何长度等限制，则改变后新生成的文本
//    tempNewText = [[tempNewText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if (maxTextLength == 0) {
        resultModel.hopeNewText = tempNewText;
        resultModel.hopeReplacementString = hopeReplacementString;
        resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
        return resultModel;
    }
    
    NSString *unchangeText = [UITextViewCJHelper substringExceptRange:range forString:oldText];
    NSInteger unchangeTextLength = unchangeText.cj_length;
//    NSInteger lastSelectedTextLength = lastSelectedText.cj_length;
//    if (unchangeTextLength > maxTextLength) { // 防止之前如10个中文字，在已有8个中文字的时候，插入3个中文字，导致变为11个中文字，长度22，超过原本限制的20
//        NSLog(@"发生异常了");
////        resultModel.hopeNewText = lastSelectedText;
////        resultModel.hopeReplacementString = hopeReplacementString;
////        resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
////        return resultModel;
//    }
    
    NSInteger tempNewTextLength = tempNewText.cj_length;
    
    NSString *newText;
    if (tempNewTextLength > maxTextLength) {
        NSInteger replacementStringMaxLength = maxTextLength-unchangeTextLength;
        // 限制10个中文字的文本框，在已有8个中文字的时候，还可以的字符个数4个
        // 如果要插入的文本所占的字符个数超过所剩余的4个，如此时视图插入3个中文字，则应该进行限制
        if (hopeReplacementString.cj_length > replacementStringMaxLength) {
            replacementStringMaxLength = replacementStringMaxLength/2;
            // 得到replacementStringMaxLength是还可以输入4个字符，但所replacementString的长度只有3，所以应该先裁剪，防止取4的时候，超出边界而崩溃
            replacementStringMaxLength = MIN(replacementStringMaxLength, hopeReplacementString.length);
            // 所以计算后是感觉要插入3个中文字，但是如果真插入3个中文字，则长度变成8*2+3*2=22，肯定超出了原本限制的最大字符长度20了,故还要再计算
            // 当然如果你插入的3个英文字，那由于英文字是按一个字符计算的，所以长度是8*2+3*1=19，没超出
        }
        NSString *newReplacementString = [hopeReplacementString substringToIndex:replacementStringMaxLength];
        if (newReplacementString.cj_length > replacementStringMaxLength) {
            NSLog(@"Error:发生异常,此时数据应该不会超过才对");
        }
        
        NSRange newRange = NSMakeRange(range.location, range.length);
        newText = [oldText stringByReplacingCharactersInRange:newRange withString:newReplacementString];//若允许改变，则会改变成的新文本
        
        isDifferentFromSystemDeal = [newReplacementString isEqualToString:string] == NO;
        resultModel.hopeNewText = newText;
        resultModel.hopeReplacementString = newReplacementString;
        resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
        
    } else {
        newText = tempNewText;
        
        resultModel.hopeNewText = newText;
        resultModel.hopeReplacementString = hopeReplacementString;
        resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
    }
    
    return resultModel;
}

/// 获取除选中部分外的其他字符串
+ (NSString *)substringExceptRange:(NSRange)range forString:(NSString *)string {
    NSLog(@"%@中处在%@范围内的剩余字符串为%@", string, NSStringFromRange(range), [string substringWithRange:range]);
    
    NSInteger beforeEndIndex = range.location;
    NSString *beforeSubstring = [string substringToIndex:beforeEndIndex];
    
    NSInteger afterBeginIndex = range.location+range.length;
    NSString *afterSubstring;
    if (afterBeginIndex > string.length-1) {
        afterSubstring = @"";
    } else {
        afterSubstring = [string substringFromIndex:afterBeginIndex];
    }
    
    NSString *substring = [NSString stringWithFormat:@"%@%@", beforeSubstring, afterSubstring];
    NSLog(@"%@中处在%@范围外的剩余字符串为%@", string, NSStringFromRange(range), substring);
    return substring;
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
