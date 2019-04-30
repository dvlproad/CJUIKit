//
//  CJIndentedStringUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

///将 字符串/字典/数组转成含缩进字符串的字符串 的工具
@interface CJIndentedStringUtil : NSObject

#pragma mark - Easy
///含缩进格式的转化 dictionary
+ (NSMutableString *)easyFormattedStringFromDictionary:(NSDictionary *)dictionary;
///含缩进格式的转化 array
+ (NSMutableString *)easyFormattedStringFromArray:(NSArray *)array;

#pragma mark - Full
+ (NSMutableString *)fullFormattedStringFromDictionary:(NSDictionary *)dictionary;


@end
