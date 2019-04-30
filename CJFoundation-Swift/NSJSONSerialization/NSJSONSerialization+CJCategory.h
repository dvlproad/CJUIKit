//
//  NSJSONSerialization+CJCategory.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/15.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通过NSJSONSerialization在jsonObject(如NSDictionary或NSArray)与NSData之间互相转换(含NSData与NSString的转换)
 *
 */
@interface NSJSONSerialization (CJCategory)

/**
 *  将jsonObject(如NSDictionary或NSArray)转为二进制数据
 *
 *  @param jsonObject   要转换类型的对象
 *
 *  @return 转换后得到的二进制数据
 */
+ (NSData *)cj_JSONDataFromJsonObject:(id)jsonObject;

/**
 *  将jsonObject(如NSDictionary或NSArray)转为字符串
 *
 *  @param jsonObject   要转换类型的对象
 *
 *  @return 转换后得到的字符串
 */
+ (NSString *)cj_JSONStringFromJsonObject:(id)jsonObject;

/**
 *  将二进制数据data转为jsonObject(如NSDictionary或NSArray)
 *
 *  @param jsonData 要转换类型的数据
 *
 *  @return 转换后得到的jsonObject
 */
+ (id)cj_JSONObjectFromData:(NSData *)jsonData;

/**
 *  将字符串string转为jsonObject(如NSDictionary或NSArray)
 *
 *  @param jsonString   要转换类型的字符串
 *
 *  @return 转换后得到的jsonObject
 */
+ (id)cj_JSONObjectFromString:(NSString *)jsonString;

@end
