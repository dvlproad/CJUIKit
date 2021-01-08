//
//  UITextViewCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UITextViewCJHelper.h"
#import "NSString+CJTextLength.h"
#import "CQSubStringUtil.h"

@implementation UITextViewCJHelper

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
+ (CQTextInputChangeResultModel *)shouldChange_newTextFromOldText:(nullable NSString *)oldText
                                    shouldChangeCharactersInRange:(NSRange)range
                                                replacementString:(NSString *)string
                                                    maxTextLength:(NSInteger)maxTextLength
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
    
    NSInteger tempNewTextLength = tempNewText.cj_length;
    if (tempNewTextLength <= maxTextLength) {
        resultModel.hopeNewText = tempNewText;
        resultModel.hopeReplacementString = hopeReplacementString;
        resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
        return resultModel;
    }
    
    // 使用系统方式处理的文本会超过我们所希望的最大长度，则我们继续裁剪。方法如下：
    NSString *unchangeText = [CQSubStringUtil substringExceptRange:range forString:oldText];
    NSInteger unchangeTextLength = unchangeText.cj_length;
    if (unchangeTextLength > maxTextLength) {
        NSString *logMessage1 = [NSString stringWithFormat:@"Warning出现特殊情况:未被替换的文本【%@】的所占的长度%zd已经超过了最大限制长度%zd。理论上是不会出现这个情况的，除非对文本框使用setText。但为了容错,我们还是处理下。", unchangeText, unchangeTextLength, maxTextLength];
        
        
        NSString *maxSubUnchangeText = [CQSubStringUtil maxSubstringFromString:unchangeText maxLength:maxTextLength];
        
        resultModel.hopeNewText = maxSubUnchangeText;
        resultModel.hopeReplacementString = nil;
        resultModel.isDifferentFromSystemDeal = YES;
        
        NSString *logMessage2 = [NSString stringWithFormat:@"计算结果为最终的文本是未替换的文本还要裁剪，而要被替换的文本和替换进去的文本都没用。即\n最终的文本是:%@", maxSubUnchangeText];
        NSLog(@"%@%@", logMessage1, logMessage2);
        
        return resultModel;
    }
    
    NSInteger replacementStringMaxLength = maxTextLength-unchangeTextLength;
    // 限制10个中文字的文本框，在已有8个中文字的时候，还可以的字符个数4个
    // 如果要插入的文本所占的字符个数超过所剩余的4个，如此时视图插入3个中文字，则应该进行限制
    NSString *newReplacementString = [CQSubStringUtil maxSubstringFromString:hopeReplacementString maxLength:replacementStringMaxLength];
    
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:newReplacementString];//若允许改变，则会改变成的新文本
    
    isDifferentFromSystemDeal = [newReplacementString isEqualToString:string] == NO;
    resultModel.hopeNewText = newText;
    resultModel.hopeReplacementString = newReplacementString;
    resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
    
    NSLog(@"将【%@】中%@范围的文本【%@】替换为%@，得到的结果是：\n最终替换文本是【%@】\n最终替换结束后的结果为【%@】", oldText, NSStringFromRange(range), [oldText substringWithRange:range], string, newReplacementString, newText);
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
