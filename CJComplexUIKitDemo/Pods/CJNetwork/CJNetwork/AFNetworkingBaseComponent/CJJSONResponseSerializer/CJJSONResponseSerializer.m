//
//  CJJSONResponseSerializer.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/19.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJJSONResponseSerializer.h"
#import "NSString+URLEncoding.h"

@implementation CJJSONResponseSerializer

//重写系统方法
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    NSData *newData = [self getNewDataByData:data]; //主要修改data
    return [super responseObjectForResponse:response data:newData error:error];
}

- (NSData *)getNewDataByData:(NSData *)data {
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 主要增加如下解码过程 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> //
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"原始的responseString = %@", responseString);//形如："%7B%22status%22%3A%224%22%2C%22msg%22%3A%22%E7%94%A8%E6%88%B7%E6%9C%AA%E6%B3%A8%E5%86%8C%2C%E6%88%96%E8%80%85%E5%AF%86%E7%A0%81%E8%BE%93%E5%85%A5%E4%B8%8D%E6%AD%A3%E7%A1%AE.%22%7D"
    
    if ([responseString hasPrefix:@"%"] || [responseString hasPrefix:@"\"%"]) {
        responseString = [responseString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        responseString = [responseString URLDecodedString];
    } else {
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    }
    if (responseString.length > 0 && ([responseString hasPrefix:@"|"] || [responseString hasPrefix:@"\""])) {
        NSInteger from = 1;
        NSInteger to = responseString.length-1;
        responseString = [responseString substringWithRange:NSMakeRange(from, to - from)];
    }
    NSLog(@"解码后的responseString = %@", responseString);//形如："{"status":"4","msg":"用户未注册,或者密码输入不正确."}"
    NSData *newData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 主要增加如上解码过程 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //
    
    return newData;
}

@end
