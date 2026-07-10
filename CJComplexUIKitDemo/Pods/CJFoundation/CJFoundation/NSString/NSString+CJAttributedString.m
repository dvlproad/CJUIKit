//
//  NSString+CJAttributedString.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/21/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSString+CJAttributedString.h"
#import "NSString+CJCut.h"

@implementation NSString (CJAttributedString)

/**
 *  对字符串中用特殊始止字符包取来的部分，按照指定的字符串配置进行自定义
 *
 *  @param startCharacter           开始的特殊字符
 *  @param endCharacter             结束的特殊字符
 *  @param stringAttributedModel    特殊字符之间的字符串需要进行自定义的那些配置(不需要设置是什么字符,因为这里已约定处理特殊字符之间的)
 *
 *  @return 符合要求的富文本
 */
- (NSMutableString *)attributedStringForSepicalBetweenStart:(NSString *)startCharacter
                                                        end:(NSString *)endCharacter
                                middleStringAttributedModel:(CJStringAttributedModel *)middleStringAttributedModel
{
    NSArray<NSString *> *stringArray = [self removeSeprateCharacterWithStart:startCharacter end:endCharacter];
    NSMutableString *lastTitle = [[NSMutableString alloc] init];
    for (NSString *compoentTitle in stringArray) {
        [lastTitle appendString:compoentTitle];
    }
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:lastTitle];;
    if (stringArray.count > 1) {
        NSInteger specialStringIndex = 1;
        if ([self hasPrefix:startCharacter]) {
            specialStringIndex = 0;
        } else if ([self hasSuffix:endCharacter]) {
            specialStringIndex = stringArray.count-1;
        } else {
            specialStringIndex = 1;
        }
        
        NSString *specialString = stringArray[specialStringIndex];
        middleStringAttributedModel.string = specialString;
        
        attributedTitle = [lastTitle attributedStringWithModels:@[middleStringAttributedModel]];
    }
    
    return attributedTitle;
}

/**
 *  对字符串中的子字符串们进行自定义设置
 *
 *  @param attributedStringModels   要设置的那些子字符串的①字符串值②字体③颜色④下划线
 *
 *  @return 子字符串们经过自定义后的新的字符串
 */
- (NSAttributedString *)attributedStringWithModels:(NSArray<CJStringAttributedModel *> *)attributedStringModels {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self];
    
    for (CJStringAttributedModel *attributedStringModel in attributedStringModels) {
        NSRange range = [self rangeOfString:attributedStringModel.string];
        if (range.location != NSNotFound) {
            [attributedString addAttribute:NSFontAttributeName value:attributedStringModel.font range:range];
            [attributedString addAttribute:NSForegroundColorAttributeName value:attributedStringModel.color range:range];
            
            if (attributedStringModel.underline) {
                [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
            }
        }
    }
    
    return attributedString;
}



@end



#pragma mark - CJStringAttributedModel类的实现

@implementation CJStringAttributedModel

@end
