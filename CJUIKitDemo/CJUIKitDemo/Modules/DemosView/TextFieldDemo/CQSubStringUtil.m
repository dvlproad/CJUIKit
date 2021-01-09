//
//  CQSubStringUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2021/1/9.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "CQSubStringUtil.h"
#import "NSString+CJTextLength.h"

typedef NS_ENUM(NSUInteger, CQCompareResult) {
    CQCompareResultOK = 1,      /**< 刚好，即本身刚好或者加上一个字后刚好 */
    CQCompareResultTooSmall,    /**< 太小，需要去找更大的 */
    CQCompareResultTooBig,      /**< 太大，需要去找更小的 */
    CQCompareResultBeyondMax,   /**< 已经超过字符串本身最大长度，取自己全身 */
};

@implementation CQSubStringUtil

#pragma mark - 范围字符串
/// 获取除选中部分外的其他字符串
+ (NSString *)substringExceptRange:(NSRange)range forString:(NSString *)string {
    NSLog(@"%@中处在%@范围内的剩余字符串为%@", string, NSStringFromRange(range), [string substringWithRange:range]);
    
    NSInteger beforeEndIndex = range.location;
    NSString *beforeSubstring = [string substringToIndex:beforeEndIndex];
    
    NSInteger afterBeginIndex = range.location+range.length;
    NSString *afterSubstring;
    if (afterBeginIndex > string.length-1) {
        afterSubstring = @"";
    } else {
        afterSubstring = [string substringFromIndex:afterBeginIndex];
    }
    
    NSString *substring = [NSString stringWithFormat:@"%@%@", beforeSubstring, afterSubstring];
    NSLog(@"%@中处在%@范围外的剩余字符串为%@", string, NSStringFromRange(range), substring);
    return substring;
}

#pragma mark - 最大字符串
/*
 *  按自定义的指定算法计算字符串占位长度时候，计算按该算法不超过指定长度的最大字符串
 （如中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSString *)maxSubstringFromString:(NSString *)hopeReplacementString
                           maxLength:(NSInteger)replacementStringMaxLength
{
    NSInteger maxIndex = [self searchMaxIndexFromString:hopeReplacementString
                                              maxLength:replacementStringMaxLength];
    NSString *maxSubstring = [hopeReplacementString substringToIndex:maxIndex];
    NSLog(@"最大字符串计算结果如下：\n【%@】\n中不超过%zd长度的最大字符串是\n【%@】，其长度为%zd", hopeReplacementString, replacementStringMaxLength, maxSubstring, maxSubstring.cj_length);
    return maxSubstring;
}

/*
 *  按自定义的指定算法计算字符串占位长度时候，计算按该算法不超过指定长度的最大字符串
 （如中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSInteger)searchMaxIndexFromString:(NSString *)hopeReplacementString
                            maxLength:(NSInteger)replacementStringMaxLength
{
    NSInteger hopeCustomLength = hopeReplacementString.cj_length;
    if (replacementStringMaxLength >= hopeCustomLength) {
        return replacementStringMaxLength;
    }
    
    NSInteger hopeLength = hopeReplacementString.length;
    NSInteger index = hopeLength/2;
    return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchStartIndex:index];
}


#pragma mark - Private Method
/*
 *  按自定义的指定算法计算字符串占位长度时候，从index位置开始寻找最大字符串的索引
 （如中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *
 *  @return 不超过长度的最大字符串的索引
 */
+ (NSInteger)__searchMaxIndexFromString:(NSString *)hopeReplacementString
                              maxLength:(NSInteger)replacementStringMaxLength
                       searchStartIndex:(NSInteger)index
{
    CQCompareResult compareResult = [self __checkIsMaxAtIndex:index
                                                    forString:hopeReplacementString
                                                withMaxLength:replacementStringMaxLength];
    if (compareResult == CQCompareResultBeyondMax) {
        return hopeReplacementString.length;
    } else if (compareResult == CQCompareResultOK) {
        //截取到该位置的子字符串刚好到最大长度，即本身刚好或者加上一个字后刚好
        return index;
    } else if (compareResult == CQCompareResultTooBig) {
        //截取到该位置的子字符串太大，先试下减去上个字是不是到了，到就取[前个位置]结束。没到那就那就去寻找更小的
        NSString *beforeHalfHopeReplacementString = [hopeReplacementString substringToIndex:index-1]; // 替换文本的一半字符串-减去一个字之后
        NSInteger beforeHalfHopeReplacementStringLength = beforeHalfHopeReplacementString.cj_length;
        if (beforeHalfHopeReplacementStringLength <= replacementStringMaxLength) {
            return index-1; //取[前个位置]
        } else {
            NSInteger unsearchLength = index;
            NSInteger nextIndex = index - unsearchLength/2; // 特殊情况1=1-1/2
            return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchStartIndex:nextIndex];
        }
        
    } else { // CQCompareResultTooSmall
        //截取到该位置的子字符串太小，试下加上下个字是不是到了，到就取[本个位置]结束。没到那就去寻找更大的
        NSString *afterHalfHopeReplacementString = [hopeReplacementString substringToIndex:index+1]; // 替换文本的一半字符串+加上一个字之后
        NSInteger afterHalfHopeReplacementStringLength = afterHalfHopeReplacementString.cj_length;
        if (afterHalfHopeReplacementStringLength > replacementStringMaxLength) {
            return index;   //取[本个位置]
        } else {
            NSInteger unsearchLength = hopeReplacementString.length - index;
            NSInteger nextIndex = index + unsearchLength/2;
            return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchStartIndex:nextIndex];
        }
    }
}


/*
 *  检查到index位置的子字符串是不是最大的了
 *
 *  @param index                        字符串到的位置
 *  @param replacementStringMaxLength   希望子字符串尽可能接近的最大长度
 *  @param hopeReplacementString        原始字符串
 *
 *  @return 该位置是否是最大位置
 */
+ (CQCompareResult)__checkIsMaxAtIndex:(NSInteger)index
                             forString:(NSString *)hopeReplacementString
                         withMaxLength:(NSInteger)replacementStringMaxLength
{
    if (index > hopeReplacementString.length) {
        return CQCompareResultBeyondMax;
    }
    
    NSString *halfHopeReplacementStringSmall = [hopeReplacementString substringToIndex:index]; // 替换文本的一半字符串
    NSInteger halfHopeReplacementStringSmallLength = halfHopeReplacementStringSmall.cj_length;
    
    if (halfHopeReplacementStringSmallLength == replacementStringMaxLength) {
        // 替换文本的一半字符串刚好，那就直接用这个
        return CQCompareResultOK;
    } else if (halfHopeReplacementStringSmallLength > replacementStringMaxLength) {
        // 替换文本的一半字符串已经超过，等会先试下减去上个字是不是到了，到就取[前个位置]结束。没到那就那就去寻找更小的
            return CQCompareResultTooBig;
    } else {
        // 替换文本的一半字符串还没到，等会先试下加上下个字是不是到了，到就取[本个位置]结束。没到那就去寻找更大的
            return CQCompareResultTooSmall;
    }
}

@end
