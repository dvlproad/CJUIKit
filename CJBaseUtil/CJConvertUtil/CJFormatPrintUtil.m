//
//  CJFormatPrintUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFormatPrintUtil.h"

@implementation CJFormatPrintUtil

/* 完整的描述请参见文件头部 */
+ (NSString *)formattedStringFromDictionary:(NSDictionary *)dictionary {
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

///从服务器得到的JSON数据解析成NSDictionary后，通过递归遍历多维的NSDictionary可以方便的把字典中的所有键值输出出来方便测试检查。
+ (NSString *)formattedStringFromDictionary2:(NSDictionary *)dictionary {
    NSString *string = [CJFormatPrintUtil formattedStringFromDictionary2:dictionary flagPrefix:@"" textPrefix:@"\t"];
    return string;
}

+ (NSString *)formattedStringFromDictionary2:(NSDictionary *)dictionary flagPrefix:(NSString *)flagPrefix textPrefix:(NSString *)textPrefix {
    NSMutableString *string = [NSMutableString string];
    
    
    [string appendFormat:@"%@{\n", flagPrefix]; // 开头有个{
    
    NSArray *keys = [dictionary allKeys];
    for (NSString *key in keys) {
        id currentObject = [dictionary objectForKey:key];
        if ([currentObject isKindOfClass:[NSDictionary class]]) {
            [string appendFormat:@"%@", textPrefix];
            [string appendFormat:@"%@:\n", key];
            
            NSDictionary *subDictionary = currentObject;
            NSString *newFlagPrefix = [NSString stringWithFormat:@"%@\t", flagPrefix];
            NSString *newTextPrefix = [NSString stringWithFormat:@"%@\t", textPrefix];
            NSString *formattedString = [CJFormatPrintUtil formattedStringFromDictionary2:subDictionary flagPrefix:newFlagPrefix textPrefix:newTextPrefix];
            [string appendFormat:@"%@\n", formattedString];
            
            
        } else if ([currentObject isKindOfClass:[NSArray class]]) {
            [string appendFormat:@"%@", textPrefix];
            [string appendFormat:@"%@:[\n",key];// 开头有个[
            
            
            NSInteger keyLength = key.length + 2;
            NSMutableString *appendKonggeString = [NSMutableString string];
            for (NSInteger i = 0; i < keyLength; i++) {
                [appendKonggeString appendFormat:@" "];
            }
            NSString *newFlagPrefix = [NSString stringWithFormat:@"%@%@", textPrefix, appendKonggeString];
            NSString *newTextPrefix = [NSString stringWithFormat:@"%@\t", newFlagPrefix];
            for (id obj in currentObject) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSString *formattedString = [CJFormatPrintUtil formattedStringFromDictionary2:obj flagPrefix:newFlagPrefix textPrefix:newTextPrefix];
                    [string appendFormat:@"%@\n", formattedString];
                } else {
                    [string appendFormat:@"%@", newTextPrefix];
                    
                    NSString *formattedString = obj;
                    [string appendFormat:@"%@,\n", formattedString];
                }
                
            }
            
            [string appendFormat:@"%@]\n", textPrefix];   // 结尾有个]
            
        } else {
            id vaule = currentObject;
            [string appendFormat:@"%@", textPrefix];
            [string appendFormat:@"%@", key];
            [string appendString:@": "];
            [string appendFormat:@"%@,\n", vaule];
        }
    }
    
    
    [string appendFormat:@"%@}", flagPrefix];   // 结尾有个}
    
    return string;
}

/* 完整的描述请参见文件头部 */
+ (NSString *)formattedStringFromArray:(NSArray *)array
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end
