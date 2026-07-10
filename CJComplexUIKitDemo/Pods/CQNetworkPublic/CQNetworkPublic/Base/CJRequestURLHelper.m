//
//  CJRequestURLHelper.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/6/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJRequestURLHelper.h"

@implementation CJRequestURLHelper

/*
 *  获取请求的Url
 *
 *  @param baseUrl      baseUrl
 *  @param apiSuffix    apiSuffix
 *
 *  @return requestUrl
 */
+ (NSString *)requestUrlWithBaseUrl:(NSString *)baseUrl apiSuffix:(NSString *)apiSuffix {
    NSMutableString *requestUrl = [NSMutableString string];
    [requestUrl appendFormat:@"%@", baseUrl];
    
    if ([baseUrl hasSuffix:@"/"] == NO) {
        if ([apiSuffix hasPrefix:@"/"]) {
            [requestUrl appendFormat:@"%@", apiSuffix];
        } else { //shouldAddSlash
            [requestUrl appendFormat:@"/%@", apiSuffix];
        }
    } else {
        if ([apiSuffix hasPrefix:@"/"]) {//shouldRemoveSlash
            [requestUrl appendFormat:@"%@", [apiSuffix substringFromIndex:1]];
        } else {
            [requestUrl appendFormat:@"%@", apiSuffix];
        }
    }
    return [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}


/*
 *  连接请求的地址与参数，返回连接后所形成的字符串
 *
 *  @param requestUrl       请求的地址
 *  @param requestParams    请求的参数
 *
 *  @return 连接后所形成的字符串
 */
+ (NSString *)connectRequestUrl:(NSString *)requestUrl params:(nullable NSDictionary *)requestParams {
    if (requestParams == nil) {
        return requestUrl;
    }
    
    //获取GET方法的参数组成的字符串requestParmasString
    NSMutableString *requestParmasString = [NSMutableString new];
    for (NSString *key in [requestParams allKeys]) {
        id obj = [requestParams valueForKey:key];
        if ([obj isKindOfClass:[NSString class]]) { //NSString
            if (requestParmasString.length != 0) {
                [requestParmasString appendString:@"&"];
            } else {
                [requestParmasString appendString:@"?"];
            }
            
            NSString *keyValueString = obj;
            [requestParmasString appendFormat:@"%@=%@", key, keyValueString];
            
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            if (requestParmasString.length != 0) {
                [requestParmasString appendString:@"&"];
            } else {
                [requestParmasString appendString:@"?"];
            }
            
            NSString *keyValueString = [obj stringValue];
            [requestParmasString appendFormat:@"%@=%@", key, keyValueString];
            
        } else if ([obj isKindOfClass:[NSArray class]]) { //NSArray
            for (NSString *value in obj) {
                if (requestParmasString.length != 0) {
                    [requestParmasString appendString:@"&"];
                } else {
                    [requestParmasString appendString:@"?"];
                }
                
                NSString *keyValueString = value;
                [requestParmasString appendFormat:@"%@=%@", key, keyValueString];
            }
        } else {
            
        }
    }
    
    NSString *fullUrlForGet = [NSString stringWithFormat:@"%@%@", requestUrl, requestParmasString];
    return fullUrlForGet;
}


@end
