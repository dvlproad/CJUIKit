//
//  CJObjectConvertUtil.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJObjectConvertUtil.h"

#import <CommonCrypto/CommonDigest.h> //md5方法要用的

@implementation CJObjectConvertUtil

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



+ (NSString*)MD5StringFromString:(NSString *)string
{
    const char *ptr = [string UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}



@end
