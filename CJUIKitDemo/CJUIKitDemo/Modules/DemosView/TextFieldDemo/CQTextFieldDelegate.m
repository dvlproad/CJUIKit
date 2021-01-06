//
//  CQTextFieldDelegate.m
//  CJUIKitDemo
//
//  Created by qian on 2021/1/6.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "CQTextFieldDelegate.h"
#import "UITextViewCJHelper.h"

@interface CQTextFieldDelegate ()

@end

@implementation CQTextFieldDelegate

//- (instancetype)initForTextField:(UITextField *)textField {
//    self = [super init];
//    if (self) {
//        textField.delegate = self;
//    }
//    return self;
//}

#pragma mark - Setup
/*
 *  设置最大长度
    @brief                  (因为文本框有可能处在cell中，所以单独提供此接口设置最大长度)
 *
 *  @param maxTextLength    最大长度（英文长度算1，中文长度算2）
 */
- (void)setupMaxTextLength:(NSInteger)maxTextLength {
    _maxTextLength = maxTextLength;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断(注意高亮的时候，长度计算以莫名其妙的规则计算)
//    UITextRange *selectedRange = textField.markedTextRange;
//    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
//    if (position == nil) {
//        
//    } else {
//        NSLog(@"exist position");
//        return YES;
//    }
    
    _shouldChangeCharactersInRange = range;
    _shouldChangeWithReplacementString = string;
    NSString *oldText = textField.text;
    NSLog(@"oldText = %@, range = %@, string = %@", oldText, NSStringFromRange(range), string);
    // 处理粘贴
//    NSString *oldText = textField.text;
//    NSString *newText = [UITextViewCJHelper shouldChange_newTextFromOldText:oldText shouldChangeCharactersInRange:range replacementString:string maxTextLength:self.maxTextLength];
//    _shouldChangeText = newText;
//    NSLog(@"希望最后得到的值是:%@", newText);    // 有时候限制了最大长度，又在中间插入超多字符。会希望原有字符不变。只插入其他数值
    
    
    
    
//    if (newText.length < oldText.length) {
//        //NSLog(@"textField deleting...from %zd to %zd", oldText.length, newText.length);
//        return YES;
//    }
//
////    NSInteger textLength = newText.cj_length;
////    if (self.maxTextLength != 0 && textLength > self.maxTextLength) { // 有限制，且超多限制，则禁止输入
////        return NO;
////    }
//
//    if (self.shouldChangeCheckBlock != nil) {
//        return self.shouldChangeCheckBlock(newText);
//    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    
    return YES;
}

@end
