//
//  NSString+CJEncryption.h
//  CJFoundationDemo
//
//  Created by dvlproad on 14-12-16.
//  Copyright (c) 2014年 ciyouzen. All rights reserved.
//

///iOS里常见的几种信息编码、加密方法 http://www.cnblogs.com/dsxniubility/p/4264777.html
#import <Foundation/Foundation.h>

@interface NSString (CJEncryption)

- (NSString *)cjMD5; //不可逆


/**
 *  将普通字符串转换成base64字符串
 *
 *  @param text 普通字符串
 *
 *  @return base64字符串
 */
+ (NSString *)cj_base64StringFromText:(NSString *)text;

/**
 *  将base64字符串转换成普通字符串
 *
 *  @param base64 base64字符串
 *
 *  @return 普通字符串
 */
+ (NSString *)cj_textFromBase64String:(NSString *)base64;

@end
