//
//  CQSubStringUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2021/1/9.
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
 *  长度计算使用【自定义cj_length算法】的时候的最大字符串
    （中文按占2个字符计算，则从10个中文字中查找不超过5个字符的字符串，应该是2个中文字）
 *
 *  @param hopeReplacementString        字符串
 *  @param replacementStringMaxLength   字符长度
 *
 *  @return 不超过长度的最大字符串
 */
+ (NSString *)maxSubstringFromString:(NSString *)hopeReplacementString
                           maxLength:(NSInteger)replacementStringMaxLength;

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
                               maxLength:(NSInteger)replacementStringMaxLength;

@end

NS_ASSUME_NONNULL_END
