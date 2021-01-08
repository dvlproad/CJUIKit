//
//  CQSubStringUtil.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2021/1/9.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQSubStringUtil : NSObject

#pragma mark - 范围字符串
/// 获取除选中部分外的其他字符串
+ (NSString *)substringExceptRange:(NSRange)range forString:(NSString *)string;

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
                           maxLength:(NSInteger)replacementStringMaxLength;

@end

NS_ASSUME_NONNULL_END
