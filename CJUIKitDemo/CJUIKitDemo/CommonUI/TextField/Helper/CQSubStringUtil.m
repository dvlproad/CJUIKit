//
//  CQSubStringUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2021/1/9.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "CQSubStringUtil.h"
#import <CJBaseUIKit/CJSubStringUtil.h>
#import <CJFoundation/NSString+CJTextLength.h>

@implementation CQSubStringUtil

#pragma mark - 范围子字符串
/// 获取除选中部分外的其他字符串
+ (NSString *)substringExceptRange:(NSRange)range forString:(NSString *)string {
    NSString *substring = [CJSubStringUtil substringExceptRange:range forString:string];
    return substring;
}


#pragma mark - 位置子字符串
/*
 *  截取字符前多少位，处理emoji表情问题（比如"好好👌"，截取前3位，系统substringToIndex会返回，而正确应该是要返回"好好👌"）
 *
 *  @param index        截取字符前多少位
 *  @param emojiString  要截取的字符串
 *
 *  @return 截取后的字符串长度
 */
+ (NSString *)substringToIndex:(NSInteger)index forEmojiString:(NSString *)emojiString
{
    NSString *substring = [CJSubStringUtil substringToIndex:index forEmojiString:emojiString];
    return substring;
}

/*
 *  【系统方式】截取字符前多少位，处理emoji表情时候会有问题（比如"好好👌"，截取前3位，系统substringToIndex会返回，而正确应该是要返回"好好👌"）
 *
 *  @param index        截取字符前多少位
 *  @param emojiString  要截取的字符串
 *
 *  @return 截取后的字符串长度
 */
+ (NSString *)sys_substringToIndex:(NSInteger)index forEmojiString:(NSString *)emojiString {
    NSString *substring = [emojiString substringToIndex:index];
    return substring;
}

#pragma mark - 最大字符串
/*
 *  长度计算使用【自定义cj_length算法】的时候的最大字符串
    （中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSString *)maxSubstringFromString:(NSString *)hopeReplacementString
                           maxLength:(NSInteger)replacementStringMaxLength
{
    NSString *maxSubstring = [CJSubStringUtil maxSubstringFromString:hopeReplacementString maxLength:replacementStringMaxLength substringToIndexBlock:^NSString * _Nonnull(NSString * _Nonnull bString, NSInteger bIndex) {
        NSString *indexSubstring = [CJSubStringUtil substringToIndex:bIndex forEmojiString:bString];
        return indexSubstring;
    } lengthCalculationBlock:^NSInteger(NSString * _Nonnull calculationString) {
        NSInteger length = calculationString.cj_length;
        return length;
    }];
    return maxSubstring;
}

/*
 *  长度计算使用【系统length算法】的时候的最大字符串
    （如中文按占1个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是5个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSString *)sys_maxSubstringFromString:(NSString *)hopeReplacementString
                               maxLength:(NSInteger)replacementStringMaxLength
{
    NSString *maxSubstring = [CJSubStringUtil maxSubstringFromString:hopeReplacementString maxLength:replacementStringMaxLength substringToIndexBlock:^NSString * _Nonnull(NSString * _Nonnull bString, NSInteger bIndex) {
        NSString *indexSubstring = [bString substringToIndex:bIndex];
        return indexSubstring;
    } lengthCalculationBlock:^NSInteger(NSString * _Nonnull calculationString) {
        NSInteger length = calculationString.length;
        return length;
    }];
    return maxSubstring;
}



@end
