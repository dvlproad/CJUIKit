//
//  UITextInputLimitCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UITextInputLimitCJHelper.h"
#import "CJSubStringUtil.h"

@implementation UITextInputLimitCJHelper

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
                                           lengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
{
    NSAssert(lengthCalculationBlock != nil, @"字符串占位长度的计算方法不能为空");
    
    UITextInputChangeResultModel *resultModel = [[UITextInputChangeResultModel alloc] initWithOriginReplacementString:string];
    if (oldText == nil) {
        oldText = @"";
    }
    BOOL isDifferentFromSystemDeal = NO;
    NSString *hopeReplacementString = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if ([hopeReplacementString isEqualToString:string] == NO) { // 系统处理是允许输入空格的
        NSLog(@"友情提示：替换的文本发生改变了，需要自己处理textField.text=处理。而该方法，可能会导致你的光标和range变化，比如中文26键下，先输入哈哈两个字，再输入5个h，选择5个h可能导致把第二个哈字删掉了。");
        isDifferentFromSystemDeal = YES;
    }
    
    if (hopeReplacementString == nil) {
        hopeReplacementString = @""; // 进行容错，确保下面调用stringByReplacingCharactersInRange的时候不会崩溃
    }
    NSString *tempNewText = [oldText stringByReplacingCharactersInRange:range withString:hopeReplacementString];//若不做任何长度等限制，则改变后新生成的文本
    //    tempNewText = [[tempNewText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if (maxTextLength == 0) {
        resultModel.hopeNewText = tempNewText;
        resultModel.hopeReplacementString = hopeReplacementString;
        resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
        return resultModel;
    }
    
    NSInteger tempNewTextLength = lengthCalculationBlock(tempNewText);
    if (tempNewTextLength <= maxTextLength) {
        resultModel.hopeNewText = tempNewText;
        resultModel.hopeReplacementString = hopeReplacementString;
        resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
        return resultModel;
    }
    
    // 使用系统方式处理的文本会超过我们所希望的最大长度，则我们继续裁剪。方法如下：
    NSString *unchangeText = [CJSubStringUtil substringExceptRange:range forString:oldText];
    NSInteger unchangeTextLength = lengthCalculationBlock(unchangeText);
    if (unchangeTextLength > maxTextLength) {
        NSString *logMessage1 = [NSString stringWithFormat:@"Warning出现特殊情况:未被替换的文本【%@】的所占的长度%zd已经超过了最大限制长度%zd。理论上是不会出现这个情况的，除非对文本框使用setText。但为了容错,我们还是处理下。", unchangeText, unchangeTextLength, maxTextLength];
        
        
        NSString *maxSubUnchangeText = [CJSubStringUtil maxSubstringFromString:unchangeText maxLength:maxTextLength substringToIndexBlock:substringToIndexBlock lengthCalculationBlock:lengthCalculationBlock];
        
        resultModel.hopeNewText = maxSubUnchangeText;
        resultModel.hopeReplacementString = nil;
        resultModel.isDifferentFromSystemDeal = YES;
        
        NSString *logMessage2 = [NSString stringWithFormat:@"计算结果为最终的文本是未替换的文本还要裁剪，而要被替换的文本和替换进去的文本都没用。即\n最终的文本是:%@", maxSubUnchangeText];
        NSLog(@"%@%@", logMessage1, logMessage2);
        
        return resultModel;
    }
    
    NSInteger replacementStringMaxLength = maxTextLength-unchangeTextLength;
    // 限制10个中文字的文本框，在已有8个中文字的时候，还可以的字符个数4个
    // 如果要插入的文本所占的字符个数超过所剩余的4个，如此时视图插入3个中文字，则应该进行限制
    NSString *newReplacementString = [CJSubStringUtil maxSubstringFromString:hopeReplacementString maxLength:replacementStringMaxLength substringToIndexBlock:substringToIndexBlock lengthCalculationBlock:lengthCalculationBlock];
    if (newReplacementString == nil) {
        newReplacementString = @""; // 进行容错，确保下面调用stringByReplacingCharactersInRange的时候不会崩溃
    }
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:newReplacementString];//若允许改变，则会改变成的新文本
    
    isDifferentFromSystemDeal = [newReplacementString isEqualToString:string] == NO;
    if (isDifferentFromSystemDeal) {
        NSLog(@"友情提示：替换的文本发生改变了，需要自己处理textField.text=处理。而该方法，可能会导致你的光标和range变化，比如中文26键下，先输入哈哈两个字，再输入5个h，选择5个h可能导致把第二个哈字删掉了。");
    }
    resultModel.hopeNewText = newText;
    resultModel.hopeReplacementString = newReplacementString;
    resultModel.isDifferentFromSystemDeal = isDifferentFromSystemDeal;
    
    NSLog(@"将【%@】中%@范围的文本【%@】替换为%@，得到的结果是：\n最终替换文本是【%@】\n最终替换结束后的结果为【%@】", oldText, NSStringFromRange(range), [oldText substringWithRange:range], string, newReplacementString, newText);
    return resultModel;
}


@end
