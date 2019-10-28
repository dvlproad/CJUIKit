//
//  NSString+CJCut.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/21/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSString+CJAttributedString.h"

@implementation NSString (CJCut)

/**
*  删除特殊字符后返回新的字符串数组
*
*  @param startCharacter   startCharacter
*  @param endCharacter     endCharacter
*
*  @return 删除特殊字符后返回的新字符串数组
*/
- (NSArray<NSString *> *)removeSeprateCharacterWithStart:(NSString *)startCharacter
                                                     end:(NSString *)endCharacter
{
    NSString *string1 = @"";
    NSString *string2 = @"";
    NSString *string3 = @"";
    
    NSArray<NSString *> *tempArray1 = [self componentsSeparatedByString:startCharacter];
    if (tempArray1.count > 1) {
        string1 = tempArray1[0];
        
        string2 = tempArray1[1];
        NSArray<NSString *> *tempArray2 = [string2 componentsSeparatedByString:endCharacter];
        if (tempArray2.count > 1) {
            string2 = tempArray2[0];
        
            string3 = tempArray2[1];
        }
    }
    //NSLog(@"string1 = %@, string2 = %@, string3 = %@", string1, string2, string3);
    
    return @[string1, string2, string3];
    
    
    /* 使用方法
    NSString *string =  @"还差{{2}}件商品参与抽奖";
    NSArray<NSString *> *stringArray = [string removeSeprateCharacterWithStart:@"{{" end:@"}}"];
    NSString *string1 = @"";
    if (stringArray.count > 0) {
        string1 = stringArray[0];
    }
    NSString *string2 = @"";
    if (stringArray.count > 1) {
        string2 = stringArray[1];
    }
    NSString *string3 = @"";
    if (stringArray.count > 2) {
        string3 = stringArray[2];
    }
    */
}

/**
*  截取字符串中两个指定字符串中间的字符串
*
*  @param startCharacter   startCharacter
*  @param endCharacter     endCharacter
*
*  @return 截取字符串中两个指定字符串中间的字符串
*/
- (NSString *)getStringBetweenSeprateCharacterWithStart:(NSString *)startCharacter
                                                    end:(NSString *)endCharacter
{
    NSRange startRange = [self rangeOfString:startCharacter];
    NSRange endRange = [self rangeOfString:endCharacter];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [self substringWithRange:range];
    return result;
}

@end
