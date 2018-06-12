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

///含缩进格式的转化 dictionary
+ (NSString *)easyFormattedStringFromDictionary:(NSDictionary *)dictionary;

+ (NSString *)fullFormattedStringFromDictionary:(NSDictionary *)dictionary;

///含缩进格式的转化 array
+ (NSString *)easyFormattedStringFromArray:(NSArray *)array;

@end
