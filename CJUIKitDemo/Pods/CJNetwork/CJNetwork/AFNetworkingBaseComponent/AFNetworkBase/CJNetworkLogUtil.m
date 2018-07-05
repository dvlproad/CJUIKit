//
//  CJNetworkLogUtil.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJNetworkLogUtil.h"
//#import <CJBaseUtil/CJIndentedStringUtil.h>
//#import <CJBaseUIKit/CJAlert.h>

@implementation CJNetworkLogUtil

+ (NSMutableString *)networkLogWithUrl:(NSString *)Url paramsString:(NSString *)paramsString responseString:(NSString *)responseString {
    NSMutableString *networkLog = [NSMutableString string];
    [networkLog appendFormat:@"地址：%@ \n", Url];
    [networkLog appendFormat:@"参数：%@ \n", paramsString];
    [networkLog appendFormat:@"结果：%@ \n", responseString];
    
    //[networkLog appendFormat:@"\n"];
    //[networkLog appendFormat:@"传给服务器的json参数：%@", allParamsJsonString];
    
    return networkLog;
}

+ (void)printNetworkLog:(NSString *)networkLog {
    NSMutableString *consoleLog = [NSMutableString string];
    [consoleLog appendFormat:@"\n\n"];
    [consoleLog appendFormat:@"  >>>>>>>>>>>>  网络请求Start  >>>>>>>>>>>>  \n"];
    [consoleLog appendFormat:@"%@\n", networkLog];
    [consoleLog appendFormat:@"  <<<<<<<<<<<<<  网络请求End  <<<<<<<<<<<<<  \n"];
    [consoleLog appendFormat:@"\n\n"];
    NSLog(@"%@", consoleLog);
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [CJAlert showDebugViewWithTitle:@"debugView" message:networkLog];
//    });
}


+ (NSString *)formattedStringFromObject:(id)object {
    //*
    if ([object isKindOfClass:[NSDictionary class]] ||
        [object isKindOfClass:[NSArray class]])
    {
        NSString *JSONString = nil;
        if ([NSJSONSerialization isValidJSONObject:object]) {
            NSError *error;
            NSData *JSONData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
            JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        }
        return JSONString;
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        return object;
    } else {
        return nil;
    }
    //*/
    
    /*
    if ([object isKindOfClass:[NSString class]]) {
        return object;
        
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        NSString *indentedString = [CJIndentedStringUtil easyFormattedStringFromDictionary:object];
        return indentedString;
        
    } else if ([object isKindOfClass:[NSString class]]) {
        NSString *indentedString = [CJIndentedStringUtil easyFormattedStringFromArray:object];
        return indentedString;
        
    } else {
        return nil;
    }
    //*/
}

@end
