//
//  CJConvertUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJConvertUtil.h"
#import "CJIndentedStringUtil.h"

#import <CommonCrypto/CommonDigest.h> //md5方法要用的

#import <objc/runtime.h>

@implementation CJConvertUtil

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

/* 完整的描述请参见文件头部 */
+ (id)JSONObjectFromObject:(id)convertObject {
    if ([convertObject isKindOfClass:[NSDictionary class]] || [convertObject isKindOfClass:[NSArray class]]) { //NSDictionary、NSArray
        return convertObject;
        
    } else {
        NSData *objectData = nil;
        if ([convertObject isKindOfClass:[NSString class]]) {    //NSString
            NSString *jsonString = (NSString *)convertObject;
            objectData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            id JSONObject = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                NSLog(@"Error:json解析失败：%@", error);
                return nil;
            }
            return JSONObject;
            
        } else if ([convertObject isKindOfClass:[NSData class]]) {      //NSData
            objectData = (NSData *)convertObject;
            
            NSError *error = nil;
            id JSONObject = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                NSLog(@"Error:json解析失败：%@", error);
                return nil;
            }
            return JSONObject;
            
        } else
            return nil;
    }
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
        
        if ([NSJSONSerialization isValidJSONObject:convertObject]) {    //NSDictionary、NSArray
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
            lastString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //*/
            
            
        } else {
            NSString *errorMessage = [NSString stringWithFormat:@"The Analyze failed class is %@", NSStringFromClass([convertObject class])];
            lastString = errorMessage;
        }
        
    }
    
    return lastString;
}



#pragma mark - Formatted
+ (NSString *)formattedStringFromObject:(id)convertObject {
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
        
        if ([NSJSONSerialization isValidJSONObject:convertObject]) {
            if ([convertObject isKindOfClass:[NSDictionary class]]) {    //NSDictionary
                NSDictionary *dictionary = (NSDictionary *)convertObject;
                lastString = [CJIndentedStringUtil easyFormattedStringFromDictionary:dictionary];
                
            } else if ([convertObject isKindOfClass:[NSArray class]]) { //NSArray
                NSArray *array = (NSArray *)convertObject;
                lastString = [CJIndentedStringUtil easyFormattedStringFromArray:array];
                
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


#pragma mark - Convert Model
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
