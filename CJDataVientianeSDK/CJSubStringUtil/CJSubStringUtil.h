//
//  CJSubStringUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2021/1/9.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJSubStringUtil : NSObject


#pragma mark - 位置子字符串
/*
 *  截取字符前多少位，处理emoji表情问题（比如"好好👌"，截取前3位，系统substringToIndex会返回，而正确应该是要返回"好好👌"）
 *
 *  @param index        截取字符前多少位
 *  @param emojiString  要截取的字符串
 *
 *  @return 截取后的字符串长度
 */
+ (NSString *)substringToIndex:(NSInteger)index forEmojiString:(NSString *)emojiString;

#pragma mark - 范围子字符串
/// 获取除选中部分外的其他字符串(主要提供给 UITextInputLimitCJHelper 中做复制粘贴时候使用）
+ (NSString *)substringExceptRange:(NSRange)range forString:(NSString *)string;

#pragma mark - 最大字符串
/*
 *  按自定义的指定算法计算字符串占位长度时候，计算按该算法不超过指定长度的最大字符串
 （如中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *  @param substringToIndexBlock        子字符串截取的方法（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如"👌",截取1，得到的不是"👌"）
 *  @param lengthCalculationBlock       字符串占位长度的计算方法
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSString *)maxSubstringFromString:(NSString *)hopeReplacementString
                           maxLength:(NSInteger)replacementStringMaxLength
               substringToIndexBlock:(NSString*(^ _Nonnull)(NSString *bString, NSInteger bIndex))substringToIndexBlock
              lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock;

@end

NS_ASSUME_NONNULL_END
