//
//  CJConvertUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJConvertUtil.h"

#import <CommonCrypto/CommonDigest.h> //md5方法要用的

#import <objc/runtime.h>

@implementation CJConvertUtil


/* 完整的描述请参见文件头部 */
+ (NSData *)cj_JSONDataFromJsonObject:(id)jsonObject
{
    if (![NSJSONSerialization isValidJSONObject:jsonObject]) {
        return nil;
    }
    
    //方法②：options设为0，来不设置(http://www.jianshu.com/p/8451fd494294)
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:&error];
    
    return jsonData;
}

/* 完整的描述请参见文件头部 */
+ (NSString *)stringFromObject2:(id)convertObject
{
    if (![NSJSONSerialization isValidJSONObject:convertObject]) {
        return nil;
    }
    
    /*
    //方法①：options设为NSJSONWritingPrettyPrinted选项
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:convertObject options:NSJSONWritingPrettyPrinted error:&error];//使用NSJSONWritingPrettyPrinted选项后会在生成的JSON中可能包含空格、换行符等格式控制字符，但是在网络传输中很明显这是不需要的，需去掉
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //第一反应，去掉结果中数不胜数的空格和回车的方法。但很快就无疾而终，因为我们的参数中会同时存在空格，这是一个大问题。
    //jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //*/
    
    ///*
    //方法②：options设为0，来不设置(http://www.jianshu.com/p/8451fd494294)
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:convertObject options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //*/
    
    //NSLog(@"jsonString = %@", jsonString);
    
    return jsonString;
}

/* 完整的描述请参见文件头部 */
+ (id)cj_JSONObjectFromData:(NSData *)jsonData {
    NSError *error = nil;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"Error:json解析失败：%@", error);
        return nil;
    }
    
    return JSONObject;
}

/* 完整的描述请参见文件头部 */
+ (id)cj_JSONObjectFromString:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization cj_JSONObjectFromData:jsonData];
}

+ (NSData *)dataFromDictionary:(NSDictionary *)dictionary {
    NSData *data = nil;
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    }
    return data;
}

+ (NSString *)stringFromDictionary:(NSDictionary *)dictionary {
    NSString *resultString = nil;
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        resultString = [string stringByAppendingString:string];
    }
    return resultString;
}


+ (NSDictionary *)dictionaryFromData:(NSData *)data {
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:object];
    if (error) {
        return nil;
    }
    return dic;
}



+ (NSString *)MD5StringFromString:(NSString *)string
{
    const char *ptr = [string UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}


+ (NSString *)stringFromObject:(id)convertObject {
    NSString *lastString = nil;
    
    if ([convertObject isKindOfClass:[NSString class]]) {    //NSString
        lastString = (NSString *)convertObject;
        
    } else if ([convertObject isKindOfClass:[NSData class]]) {      //NSData
        NSData *objectData = (NSData *)convertObject;
        lastString = [[NSString alloc] initWithData:objectData encoding:NSUTF8StringEncoding];
        
    } else { //其他：包括NSDictionary、NSArray、Model等
        id JSONObject = nil;
        if ([NSJSONSerialization isValidJSONObject:convertObject]) {
            JSONObject = convertObject;
        } else {
            JSONObject = [self dictionaryFromModel:convertObject];
        }
        
        if ([NSJSONSerialization isValidJSONObject:JSONObject]) {//NSDictionary、NSArray
            if ([JSONObject isKindOfClass:[NSDictionary class]]) {
                lastString = [self printDictionary:JSONObject];
            } else if ([JSONObject isKindOfClass:[NSArray class]]) {
                lastString = [self printArray:JSONObject];
            } else {
                NSError *error;
                NSData *objectData = [NSJSONSerialization dataWithJSONObject:JSONObject options:0 error:&error];
                lastString = [[NSString alloc] initWithData:objectData encoding:NSUTF8StringEncoding];
            }
            
        } else {
            lastString = [NSString stringWithFormat:@"The Analyze failed class is %@", NSStringFromClass([convertObject class])];
        }
    }
    
    return lastString;
}


+ (NSString *)printDictionary:(NSDictionary *)dictionary {
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


+ (NSString *)printArray:(NSArray *)array
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
}  //性能呢


/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary *)dictionaryFromModel:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}

+ (id)getObjectInternal:(id)obj {
    if([obj isKindOfClass:[NSString class]] ||
       [obj isKindOfClass:[NSNumber class]] ||
       [obj isKindOfClass:[NSNull class]]) {
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0; i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self dictionaryFromModel:obj];
    
}




@end
