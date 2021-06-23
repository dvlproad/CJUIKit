//
//  CJTextViewDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJTextViewDelegate.h"

@interface CJTextViewDelegate () {
    
}
@property (nullable, nonatomic, copy) BOOL(^inputTextCheckHandle)(NSString *bInputText);   /**< 此次想要输入的文本能否真正输入的判断（如\n回车） */
@property (nonatomic, copy, readonly) BOOL (^extraShouldChangeCheckBlock)(NSString *newText);  /**< 在已封装shouldChange中增加额外的能否输入的判断（如输入手机号码的时候，希望会系统处理出的新文本判断，在新文本不合法的时候能有对应toast提示） */

@end

@implementation CJTextViewDelegate

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
 *  @param inputTextCheckHandle         此次想要输入的文本能否真正输入的判断（如\n回车，为nil的时候，输入\n会执行resignFirstResponder）
 *  @param extraShouldChangeCheckBlock  增加的额外能否输入的判断（这里添加的block一般都不应该再做长度限制了）
 */
- (void)setupMaxTextLength:(NSInteger)maxTextLength
      inputTextCheckHandle:(BOOL(^ _Nullable)(NSString *bInputText))inputTextCheckHandle
addExtraShouldChangeCheckBlock:(BOOL (^ _Nullable)(NSString *newText))extraShouldChangeCheckBlock
{
    _maxTextLength = maxTextLength;
    _inputTextCheckHandle = inputTextCheckHandle;
    _extraShouldChangeCheckBlock = extraShouldChangeCheckBlock;
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.inputTextCheckHandle) {
        BOOL canInput = self.inputTextCheckHandle(text);
        if (canInput == NO) {
            return NO;
        }
    } else {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
    }
    
    _shouldChangeWithOldText = textView.text;
    _shouldChangeCharactersInRange = range;
    _shouldChangeWithReplacementString = text;
    
    /// 以下为额外增加的判断 ///
    NSString *oldText = textView.text;
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:text];//若允许改变，则会改变成的新文本
    //NSLog(@"oldText = %@, newText = %@, range = %@, string = %@", oldText, newText, NSStringFromRange(range), string);
//    if (newText.length < oldText.length) {
//        //NSLog(@"textView deleting...from %zd to %zd", oldText.length, newText.length);
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

- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}

@end
