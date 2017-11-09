//
//  NSString+CJEncryption.m
//  CJFoundationDemo
//
//  Created by dvlproad on 16/12/14.
//  Copyright (c) 2014年 ciyouzen. All rights reserved.
//

#import "NSString+CJEncryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CJEncryption)

- (NSString *)cjMD5
{
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) 
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

/** 完整的描述请参见文件头部 */
+ (NSString *)cj_base64StringFromText:(NSString *)text {
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
    return base64String;
}

/* 完整的描述请参见文件头部 */
+ (NSString *)cj_textFromBase64String:(NSString *)base64 {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:0];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return text;
}

@end
