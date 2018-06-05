//
//  CJFormatPrintUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJFormatPrintUtil : NSObject

///含缩进格式的转化 dictionary
+ (NSString *)formattedStringFromDictionary:(NSDictionary *)dictionary;

+ (NSString *)formattedStringFromDictionary2:(NSDictionary *)dictionary;

///含缩进格式的转化 array
+ (NSString *)formattedStringFromArray:(NSArray *)array;

@end
