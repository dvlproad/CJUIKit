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
    if (index == 0) {
        return nil;
    }
    
    NSInteger emojiStringLength = emojiString.length;
    if(index > emojiStringLength) {
        return emojiString;
    }
    
    @autoreleasepool {
        NSString *subStr = emojiString;
        NSRange range;
        NSInteger currentIndex = 0;
        for (int i = 0; i< emojiStringLength; i += range.length) {
            range = [emojiString rangeOfComposedCharacterSequenceAtIndex:i];
            NSString *charrrr = [emojiString substringToIndex:range.location + range.length];
            currentIndex ++;
            if (currentIndex == index) {
                subStr = charrrr;
                break;
            }
        }
        return subStr;
    }
}

#pragma mark - 范围子字符串
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
 *  @param substringToIndexBlock        子字符串截取的方法（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如"👌",截取1，得到的不是"👌"）
 *  @param lengthCalculationBlock       字符串占位长度的计算方法
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSString *)maxSubstringFromString:(NSString *)hopeReplacementString
                           maxLength:(NSInteger)replacementStringMaxLength
               substringToIndexBlock:(NSString*(^ _Nonnull)(NSString *bString, NSInteger bIndex))substringToIndexBlock
              lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    NSInteger maxIndex = [self searchMaxIndexFromString:hopeReplacementString
                                              maxLength:replacementStringMaxLength
                                  substringToIndexBlock:substringToIndexBlock
                                 lengthCalculationBlock:lengthCalculationBlock];
    
    NSString *maxSubstring = [self substringToIndex:maxIndex forEmojiString:hopeReplacementString]; //"一二👌三四五"
    //NSLog(@"最大字符串计算结果如下：\n【%@】\n中不超过%zd长度的最大字符串是\n【%@】，其长度为%zd", hopeReplacementString, replacementStringMaxLength, maxSubstring, lengthCalculationBlock(maxSubstring));
    return maxSubstring;
}

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
+ (NSInteger)searchMaxIndexFromString:(NSString *)hopeReplacementString
                            maxLength:(NSInteger)replacementStringMaxLength
                substringToIndexBlock:(NSString*(^ _Nonnull)(NSString *bString, NSInteger bIndex))substringToIndexBlock
               lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    NSInteger hopeCustomLength = lengthCalculationBlock(hopeReplacementString);
    if (replacementStringMaxLength >= hopeCustomLength) {
        return hopeCustomLength;
    }
    
    NSInteger hopeLength = hopeReplacementString.length;
    NSInteger searchMinIndex = 0;
    NSInteger searchMaxIndex = hopeLength;
    return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchMinIndex:searchMinIndex searchMaxIndex:searchMaxIndex substringToIndexBlock:substringToIndexBlock lengthCalculationBlock:lengthCalculationBlock];
}


#pragma mark - Private Method
/*
 *  按自定义的指定算法计算字符串占位长度时候，计算从searchMinIndex到searchMaxIndex中哪个checkIndex是最大字符串的索引位置
 （如中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *  @param searchMinIndex               查找最小的位置
 *  @param searchMaxIndex               查找最大的位置
 *  @param substringToIndexBlock        子字符串截取的方法（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如"👌",截取1，得到的不是"👌"）
 *  @param lengthCalculationBlock       字符串占位长度的计算方法
 *
 *  @return 不超过长度的最大字符串的索引
 */
+ (NSInteger)__searchMaxIndexFromString:(NSString *)hopeReplacementString
                              maxLength:(NSInteger)replacementStringMaxLength
                         searchMinIndex:(NSInteger)searchMinIndex
                         searchMaxIndex:(NSInteger)searchMaxIndex
                  substringToIndexBlock:(NSString*(^ _Nonnull)(NSString *bString, NSInteger bIndex))substringToIndexBlock
                 lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(substringToIndexBlock != nil, @"子字符串截取的方法不能为空（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如【👌】,截取1，得到的不是【👌】）");
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    NSInteger checkIndex = searchMinIndex+(searchMaxIndex-searchMinIndex)/2;
    CJCompareResult compareResult = [self __checkIsMaxAtIndex:checkIndex
                                                    forString:hopeReplacementString
                                                withMaxLength:replacementStringMaxLength
                                        substringToIndexBlock:substringToIndexBlock
                                       lengthCalculationBlock:lengthCalculationBlock];
    if (compareResult == CJCompareResultBeyondMax) {
        return hopeReplacementString.length;
    } else if (compareResult == CJCompareResultOK) {
        //截取到该位置的子字符串刚好到最大长度，即本身刚好或者加上一个字后刚好
        return checkIndex;
    } else if (compareResult == CJCompareResultTooBig) {
        //截取到该位置的子字符串太大，先试下减去上个字是不是到了，到就取[前个位置]结束。没到那就那就去寻找更小的
        NSString *beforeHalfHopeReplacementString = substringToIndexBlock(hopeReplacementString, checkIndex-1); // 替换文本的一半字符串-减去一个字之后
        NSInteger beforeHalfHopeReplacementStringLength = lengthCalculationBlock(beforeHalfHopeReplacementString);
        if (beforeHalfHopeReplacementStringLength <= replacementStringMaxLength) {
            return checkIndex-1; //取[前个位置]
        } else {
            NSInteger newSearchMinIndex = searchMinIndex;
            NSInteger newSearchMaxIndex = checkIndex;
            return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchMinIndex:newSearchMinIndex searchMaxIndex:newSearchMaxIndex substringToIndexBlock:substringToIndexBlock lengthCalculationBlock:lengthCalculationBlock];
        }
        
    } else { // CJCompareResultTooSmall
        //截取到该位置的子字符串太小，试下加上下个字是不是到了，到就取[本个位置]结束。没到那就去寻找更大的
        NSString *afterHalfHopeReplacementString =  substringToIndexBlock(hopeReplacementString, checkIndex+1); // 替换文本的一半字符串+加上一个字之后
        NSInteger afterHalfHopeReplacementStringLength = lengthCalculationBlock(afterHalfHopeReplacementString);
        if (afterHalfHopeReplacementStringLength == replacementStringMaxLength) {
            return checkIndex+1; //取[下个位置]
        } else if (afterHalfHopeReplacementStringLength > replacementStringMaxLength) {
            return checkIndex;   //取[本个位置]
        } else {
            NSInteger newSearchMinIndex = checkIndex;
            NSInteger newSearchMaxIndex = searchMaxIndex;
            return [self __searchMaxIndexFromString:hopeReplacementString maxLength:replacementStringMaxLength searchMinIndex:newSearchMinIndex searchMaxIndex:newSearchMaxIndex substringToIndexBlock:substringToIndexBlock lengthCalculationBlock:lengthCalculationBlock];
        }
    }
}


/*
 *  检查到index位置的子字符串是不是最大的了
 *
 *  @param index                        字符串到的位置
 *  @param replacementStringMaxLength   希望子字符串尽可能接近的最大长度
 *  @param hopeReplacementString        原始字符串
 *  @param substringToIndexBlock        子字符串截取的方法（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如"👌",截取1，得到的不是"👌"）
 *  @param lengthCalculationBlock       字符串占位长度的计算方法
 *
 *  @return 该位置是否是最大位置
 */
+ (CJCompareResult)__checkIsMaxAtIndex:(NSInteger)index
                             forString:(NSString *)hopeReplacementString
                         withMaxLength:(NSInteger)replacementStringMaxLength
                 substringToIndexBlock:(NSString*(^ _Nonnull)(NSString *bString, NSInteger bIndex))substringToIndexBlock
                lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(substringToIndexBlock != nil, @"子字符串截取的方法不能为空（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如【👌】,截取1，得到的不是【👌】）");
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    if (index > hopeReplacementString.length) {
        return CJCompareResultBeyondMax;
    }
    
    NSString *halfHopeReplacementStringSmall = substringToIndexBlock(hopeReplacementString, index); // 替换文本的一半字符串
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
