//
//  UITextInputLimitCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITextInputChangeResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextInputLimitCJHelper : NSObject


/*
 *  根据最大长度获取shouldChange的时候返回的newText
 *
 *  @param oldText                  oldText
 *  @param range                    range
 *  @param string                   string
 *  @param maxTextLength            maxTextLength(为0的时候不做长度限制)
 *  @param substringToIndexBlock    子字符串截取的方法（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如"👌",截取1，得到的不是"👌"）
 *  @param lengthCalculationBlock   字符串占位长度的计算方法
 *
 *  @return newText
 */
+ (UITextInputChangeResultModel *)shouldChange_newTextFromOldText:(nullable NSString *)oldText
                                    shouldChangeCharactersInRange:(NSRange)range
                                                replacementString:(NSString *)string
                                                    maxTextLength:(NSInteger)maxTextLength
                                            substringToIndexBlock:(NSString*(^ _Nonnull)(NSString *bString, NSInteger bIndex))substringToIndexBlock
                                           lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock;

@end

NS_ASSUME_NONNULL_END
