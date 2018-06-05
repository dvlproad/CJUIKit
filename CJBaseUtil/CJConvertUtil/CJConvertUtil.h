//
//  CJConvertUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  [iOS 打印中文字典,数组,控制台输出中文,并保持缩进格式](https://www.jianshu.com/p/040293327e18)

#import <Foundation/Foundation.h>
#import "NSJSONSerialization+CJCategory.h"

@interface CJConvertUtil : NSObject

+ (NSData *)dataFromDictionary:(NSDictionary *)dictionary;

+ (NSString *)stringFromDictionary:(NSDictionary *)dictionary;

+ (NSDictionary *)dictionaryFromData:(NSData *)data;

/* Source : http://iphonedevelopertips.com/core-services/create-md5-hash-from-nsstring-nsdata-or-file.html */
+ (NSString*)MD5StringFromString:(NSString *)string;



+ (NSString *)stringFromObject:(id)convertObject;
/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary *)dictionaryFromModel:(id)obj;

@end
