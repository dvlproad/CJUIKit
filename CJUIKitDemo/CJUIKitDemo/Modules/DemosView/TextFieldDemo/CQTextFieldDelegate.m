//
//  CQTextFieldDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTextFieldDelegate.h"

@interface CQTextFieldDelegate ()

@end

@implementation CQTextFieldDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

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
    
    _shouldChangeWithOldText = textField.text;
    _shouldChangeCharactersInRange = range;
    _shouldChangeWithReplacementString = string;
    
    /// 以下为额外增加的判断 ///
    NSString *oldText = textField.text;
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:string];//若允许改变，则会改变成的新文本
    //NSLog(@"oldText = %@, newText = %@, range = %@, string = %@", oldText, newText, NSStringFromRange(range), string);
    if (newText.length < oldText.length) {
        //NSLog(@"textField deleting...from %zd to %zd", oldText.length, newText.length);
        return YES;
    }
    if (self.maxTextLength != 0 && newText.length > self.maxTextLength+10) { // 有限制，且超过最大值+10的弹性限制(因为非高亮的文本长度偏长，且有时候打一个字可能需要输入几个字符才会有)，则禁止输入
        return NO;
    }
    /// 以上为额外增加的判断 ///
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    
    return YES;
}

@end
