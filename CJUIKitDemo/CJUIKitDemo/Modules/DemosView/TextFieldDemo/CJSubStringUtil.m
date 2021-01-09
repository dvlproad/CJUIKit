//
//  CJSubStringUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2021/1/9.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "CJSubStringUtil.h"

typedef NS_ENUM(NSUInteger, CJCompareResult) {
    CJCompareResultOK = 1,      /**< 刚好，即本身刚好或者加上一个字后刚好 */
    CJCompareResultTooSmall,    /**< 太小，需要去找更大的 */
    CJCompareResultTooBig,      /**< 太大，需要去找更小的 */
    CJCompareResultBeyondMax,   /**< 已经超过字符串本身最大长度，取自己全身 */
};

@implementation CJSubStringUtil

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
 *  @param lengthCalculationBlock       字符串占位长度的计算方法
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSString *)maxSubstringFromString:(NSString *)hopeReplacementString
                           maxLength:(NSInteger)replacementStringMaxLength
              lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    NSInteger maxIndex = [self searchMaxIndexFromString:hopeReplacementString
                                              maxLength:replacementStringMaxLength
                                 lengthCalculationBlock:lengthCalculationBlock];
    NSString *maxSubstring = [hopeReplacementString substringToIndex:maxIndex];
    NSLog(@"最大字符串计算结果如下：\n【%@】\n中不超过%zd长度的最大字符串是\n【%@】，其长度为%zd", hopeReplacementString, replacementStringMaxLength, maxSubstring, lengthCalculationBlock(maxSubstring));
    return maxSubstring;
}

/*
 *  按自定义的指定算法计算字符串占位长度时候，计算按该算法不超过指定长度的最大字符串
 （如中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *  @param lengthCalculationBlock       字符串占位长度的计算方法
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSInteger)searchMaxIndexFromString:(NSString *)hopeReplacementString
                            maxLength:(NSInteger)replacementStringMaxLength
               lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    NSInteger hopeCustomLength = lengthCalculationBlock(hopeReplacementString);
    if (replacementStringMaxLength >= hopeCustomLength) {
        return hopeCustomLength;
    }
    
    NSInteger hopeLength = hopeReplacementString.length;
    NSInteger index = hopeLength/2;
    return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchStartIndex:index lengthCalculationBlock:lengthCalculationBlock];
}


#pragma mark - Private Method
/*
 *  按自定义的指定算法计算字符串占位长度时候，从index位置开始寻找最大字符串的索引
 （如中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *  @param index                        查找开始的位置
 *  @param lengthCalculationBlock       字符串占位长度的计算方法
 *
 *  @return 不超过长度的最大字符串的索引
 */
+ (NSInteger)__searchMaxIndexFromString:(NSString *)hopeReplacementString
                              maxLength:(NSInteger)replacementStringMaxLength
                       searchStartIndex:(NSInteger)index
                 lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    CJCompareResult compareResult = [self __checkIsMaxAtIndex:index
                                                    forString:hopeReplacementString
                                                withMaxLength:replacementStringMaxLength
                                       lengthCalculationBlock:lengthCalculationBlock];
    if (compareResult == CJCompareResultBeyondMax) {
        return hopeReplacementString.length;
    } else if (compareResult == CJCompareResultOK) {
        //截取到该位置的子字符串刚好到最大长度，即本身刚好或者加上一个字后刚好
        return index;
    } else if (compareResult == CJCompareResultTooBig) {
        //截取到该位置的子字符串太大，先试下减去上个字是不是到了，到就取[前个位置]结束。没到那就那就去寻找更小的
        NSString *beforeHalfHopeReplacementString = [hopeReplacementString substringToIndex:index-1]; // 替换文本的一半字符串-减去一个字之后
        NSInteger beforeHalfHopeReplacementStringLength = lengthCalculationBlock(beforeHalfHopeReplacementString);
        if (beforeHalfHopeReplacementStringLength <= replacementStringMaxLength) {
            return index-1; //取[前个位置]
        } else {
            NSInteger unsearchLength = index;
            NSInteger nextIndex = index - unsearchLength/2; // 特殊情况1=1-1/2
            return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchStartIndex:nextIndex lengthCalculationBlock:lengthCalculationBlock];
        }
        
    } else { // CJCompareResultTooSmall
        //截取到该位置的子字符串太小，试下加上下个字是不是到了，到就取[本个位置]结束。没到那就去寻找更大的
        NSString *afterHalfHopeReplacementString = [hopeReplacementString substringToIndex:index+1]; // 替换文本的一半字符串+加上一个字之后
        NSInteger afterHalfHopeReplacementStringLength = lengthCalculationBlock(afterHalfHopeReplacementString);
        if (afterHalfHopeReplacementStringLength > replacementStringMaxLength) {
            return index;   //取[本个位置]
        } else {
            NSInteger unsearchLength = hopeReplacementString.length - index;
            NSInteger nextIndex = index + unsearchLength/2;
            return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchStartIndex:nextIndex lengthCalculationBlock:lengthCalculationBlock];
        }
    }
}


/*
 *  检查到index位置的子字符串是不是最大的了
 *
 *  @param index                        字符串到的位置
 *  @param replacementStringMaxLength   希望子字符串尽可能接近的最大长度
 *  @param hopeReplacementString        原始字符串
 *  @param lengthCalculationBlock       字符串占位长度的计算方法
 *
 *  @return 该位置是否是最大位置
 */
+ (CJCompareResult)__checkIsMaxAtIndex:(NSInteger)index
                             forString:(NSString *)hopeReplacementString
                         withMaxLength:(NSInteger)replacementStringMaxLength
                lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    if (index > hopeReplacementString.length) {
        return CJCompareResultBeyondMax;
    }
    
    NSString *halfHopeReplacementStringSmall = [hopeReplacementString substringToIndex:index]; // 替换文本的一半字符串
    NSInteger halfHopeReplacementStringSmallLength = lengthCalculationBlock(halfHopeReplacementStringSmall);
    
    if (halfHopeReplacementStringSmallLength == replacementStringMaxLength) {
        // 替换文本的一半字符串刚好，那就直接用这个
        return CJCompareResultOK;
    } else if (halfHopeReplacementStringSmallLength > replacementStringMaxLength) {
        // 替换文本的一半字符串已经超过，等会先试下减去上个字是不是到了，到就取[前个位置]结束。没到那就那就去寻找更小的
            return CJCompareResultTooBig;
    } else {
        // 替换文本的一半字符串还没到，等会先试下加上下个字是不是到了，到就取[本个位置]结束。没到那就去寻找更大的
            return CJCompareResultTooSmall;
    }
}

@end
