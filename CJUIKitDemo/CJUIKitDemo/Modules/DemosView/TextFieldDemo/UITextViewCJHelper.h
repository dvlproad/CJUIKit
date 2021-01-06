//
//  UITextViewCJHelper.h
//  BiaoliApp
//
//  Created by qian on 2020/12/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextViewCJHelper : NSObject


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
+ (NSString *)shouldChange_newTextFromOldText:(nullable NSString *)oldText shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string maxTextLength:(NSInteger)maxTextLength;

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
