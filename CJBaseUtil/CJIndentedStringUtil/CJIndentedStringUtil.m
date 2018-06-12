//
//  CJIndentedStringUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJIndentedStringUtil.h"

@implementation CJIndentedStringUtil

/* 完整的描述请参见文件头部 */
+ (NSString *)easyFormattedStringFromDictionary:(NSDictionary *)dictionary {
    NSMutableString *indentedString = [NSMutableString string];
    
    // 开头有个{
    [indentedString appendString:@"{\n"];
    
    // 遍历所有的键值对
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [indentedString appendFormat:@"\t%@", key];
        [indentedString appendString:@" : "];
        [indentedString appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [indentedString appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [indentedString rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [indentedString deleteCharactersInRange:range];
    
    return indentedString;
}

///从服务器得到的JSON数据解析成NSDictionary后，通过递归遍历多维的NSDictionary可以方便的把字典中的所有键值输出出来方便测试检查。
+ (NSString *)fullFormattedStringFromDictionary:(NSDictionary *)dictionary {
    NSString *indentedString = [CJIndentedStringUtil fullFormattedStringFromDictionary:dictionary flagPrefix:@"" textPrefix:@"\t"];
    return indentedString;
}

+ (NSString *)fullFormattedStringFromDictionary:(NSDictionary *)dictionary flagPrefix:(NSString *)flagPrefix textPrefix:(NSString *)textPrefix {
    NSMutableString *indentedString = [NSMutableString string];
    
    
    [indentedString appendFormat:@"%@{\n", flagPrefix]; // 开头有个{
    
    NSArray *keys = [dictionary allKeys];
    for (NSString *key in keys) {
        id currentObject = [dictionary objectForKey:key];
        if ([currentObject isKindOfClass:[NSDictionary class]]) {
            [indentedString appendFormat:@"%@", textPrefix];
            [indentedString appendFormat:@"%@:\n", key];
            
            NSDictionary *subDictionary = currentObject;
            NSString *newFlagPrefix = [NSString stringWithFormat:@"%@\t", flagPrefix];
            NSString *newTextPrefix = [NSString stringWithFormat:@"%@\t", textPrefix];
            NSString *formattedString = [CJIndentedStringUtil fullFormattedStringFromDictionary:subDictionary flagPrefix:newFlagPrefix textPrefix:newTextPrefix];
            [indentedString appendFormat:@"%@\n", formattedString];
            
            
        } else if ([currentObject isKindOfClass:[NSArray class]]) {
            [indentedString appendFormat:@"%@", textPrefix];
            [indentedString appendFormat:@"%@:[\n",key];// 开头有个[
            
            
            NSInteger keyLength = key.length + 2;
            NSMutableString *appendKonggeString = [NSMutableString string];
            for (NSInteger i = 0; i < keyLength; i++) {
                [appendKonggeString appendFormat:@" "];
            }
            NSString *newFlagPrefix = [NSString stringWithFormat:@"%@%@", textPrefix, appendKonggeString];
            NSString *newTextPrefix = [NSString stringWithFormat:@"%@\t", newFlagPrefix];
            for (id obj in currentObject) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSString *formattedString = [CJIndentedStringUtil fullFormattedStringFromDictionary:obj flagPrefix:newFlagPrefix textPrefix:newTextPrefix];
                    [indentedString appendFormat:@"%@\n", formattedString];
                } else {
                    [indentedString appendFormat:@"%@", newTextPrefix];
                    
                    NSString *formattedString = obj;
                    [indentedString appendFormat:@"%@,\n", formattedString];
                }
                
            }
            
            [indentedString appendFormat:@"%@]\n", textPrefix];   // 结尾有个]
            
        } else {
            id vaule = currentObject;
            [indentedString appendFormat:@"%@", textPrefix];
            [indentedString appendFormat:@"%@", key];
            [indentedString appendString:@": "];
            [indentedString appendFormat:@"%@,\n", vaule];
        }
    }
    
    
    [indentedString appendFormat:@"%@}", flagPrefix];   // 结尾有个}
    
    return indentedString;
}

/* 完整的描述请参见文件头部 */
+ (NSString *)easyFormattedStringFromArray:(NSArray *)array
{
    NSMutableString *indentedString = [NSMutableString string];
    
    // 开头有个[
    [indentedString appendString:@"[\n"];
    
    // 遍历所有的元素
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [indentedString appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [indentedString appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [indentedString rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [indentedString deleteCharactersInRange:range];
    
    return indentedString;
}

@end
