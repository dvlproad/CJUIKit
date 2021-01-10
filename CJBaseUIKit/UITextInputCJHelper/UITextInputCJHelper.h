//
//  UITextInputCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITextInputChangeResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextInputCJHelper : NSObject


/*
 *  根据最大长度获取shouldChange的时候返回的newText
 *
 *  @param oldText                  oldText
 *  @param range                    range
 *  @param string                   string
 *  @param maxTextLength            maxTextLength(为0的时候不做长度限制)
 *  @param lengthCalculationBlock   字符串占位长度的计算方法
 *
 *  @return newText
 */
+ (UITextInputChangeResultModel *)shouldChange_newTextFromOldText:(nullable NSString *)oldText
                                    shouldChangeCharactersInRange:(NSRange)range
                                                replacementString:(NSString *)string
                                                    maxTextLength:(NSInteger)maxTextLength
                                           lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock;

@end

NS_ASSUME_NONNULL_END
