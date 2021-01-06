//
//  CQTextFieldDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
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
    
    _shouldChangeWithOldText = textField.text;
    _shouldChangeCharactersInRange = range;
    _shouldChangeWithReplacementString = string;
    NSString *oldText = textField.text;
    NSLog(@"oldText = %@, range = %@, string = %@", oldText, NSStringFromRange(range), string);

    
//    if (newText.length < oldText.length) {
//        //NSLog(@"textField deleting...from %zd to %zd", oldText.length, newText.length);
//        return YES;
//    }
//
////    NSInteger textLength = newText.cj_length;
////    if (self.maxTextLength != 0 && textLength > self.maxTextLength) { // 有限制，且超多限制，则禁止输入
////        return NO;
////    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    
    return YES;
}

@end
