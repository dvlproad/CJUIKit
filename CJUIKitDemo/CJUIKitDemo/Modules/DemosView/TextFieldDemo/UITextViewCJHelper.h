//
//  UITextViewCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CQTextInputChangeResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextViewCJHelper : NSObject


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
                             lastSelectedText:(nullable NSString *)lastSelectedText;


#pragma mark - 设置光标
/*
 *  选择文本框光标位置
 *
 *  @param textField    文本框
 *  @param index        光标要放的位置
 */
+ (void)setCursorLocationForTextField:(UITextField *)textField atIndex:(NSInteger)index;


/*
 *  根据最大长度获取didChange的时候返回的newText
 *
 *  @param shouldChangeText     shouldChangeText（这是shouldChange种获取的新值）
 *  @param maxTextLength        maxTextLength
 *
 *  @return newText
 */
+ (NSString *)didChange_newTextFromShouldChangeText:(NSString *)shouldChangeText maxTextLength:(NSInteger)maxTextLength;

+ (BOOL)textFieldDidChange:(UITextField *)textField maxTextLength:(NSInteger)maxTextLength;

+ (BOOL)textViewDidChange:(UITextView *)textView maxTextLength:(NSInteger)maxTextLength;

@end

NS_ASSUME_NONNULL_END
