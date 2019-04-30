//
//  NSJSONSerialization+CJCategory.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/15.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import "NSJSONSerialization+CJCategory.h"

@implementation NSJSONSerialization (CJCategory)

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
+ (NSString *)cj_JSONStringFromJsonObject:(id)jsonObject
{
    if (![NSJSONSerialization isValidJSONObject:jsonObject]) {
        return nil;
    }
    
    /*
     //方法①：options设为NSJSONWritingPrettyPrinted选项
     NSError *error = nil;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];//使用NSJSONWritingPrettyPrinted选项后会在生成的JSON中可能包含空格、换行符等格式控制字符，但是在网络传输中很明显这是不需要的，需去掉
     NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
     
     //第一反应，去掉结果中数不胜数的空格和回车的方法。但很快就无疾而终，因为我们的参数中会同时存在空格，这是一个大问题。
     //jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
     //jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
     //*/
    
    ///*
    //方法②：options设为0，来不设置(http://www.jianshu.com/p/8451fd494294)
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:&error];
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


@end
