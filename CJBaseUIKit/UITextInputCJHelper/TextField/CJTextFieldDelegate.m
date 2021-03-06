//
//  CJTextFieldDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJTextFieldDelegate.h"

@interface CJTextFieldDelegate () {
    
}
@property (nonatomic, copy, readonly) BOOL (^extraShouldChangeCheckBlock)(NSString *newText);  /**< 在已封装shouldChange中增加额外的能否输入的判断（如输入手机号码的时候，希望会系统处理出的新文本判断，在新文本不合法的时候能有对应toast提示） */

@end

@implementation CJTextFieldDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Setup
/*
 *  设置最大长度，并在已封装shouldChange中增加额外的能否输入的判断（如输入手机号码的时候，希望会系统处理出的新文本判断，在新文本不合法的时候能有对应toast提示）
 *
 *  @param maxTextLength                最大长度（英文长度算1，中文长度算2）
 *  @param extraShouldChangeCheckBlock  增加的额外能否输入的判断（这里添加的block一般都不应该再做长度限制了）
 */
- (void)setupMaxTextLength:(NSInteger)maxTextLength addExtraShouldChangeCheckBlock:(BOOL (^ _Nullable)(NSString *newText))extraShouldChangeCheckBlock {
    _maxTextLength = maxTextLength;
    _extraShouldChangeCheckBlock = extraShouldChangeCheckBlock;
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
//    if (newText.length < oldText.length) {
//        //NSLog(@"textField deleting...from %zd to %zd", oldText.length, newText.length);
//        return YES;
//    }
//    if (self.maxTextLength != 0 && range.length == 0 && newText.length > self.maxTextLength+10) {
//        // 待修复：目前无法知道是输入，还是粘贴。range.length == 0 如果是没有替换文本的插入或者粘贴的话，为避免输入太多，增加体验，额外增加弹性输入限制。
//        // 有限制，且超过最大值+10的弹性限制(因为非高亮的文本长度偏长，且有时候打一个字可能需要输入几个字符才会有)，则禁止输入
//        return NO;
//    }
    /// 以上为额外增加的判断 ///
    
    if (self.extraShouldChangeCheckBlock) {
        return self.extraShouldChangeCheckBlock(newText);
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    
    return YES;
}

@end
