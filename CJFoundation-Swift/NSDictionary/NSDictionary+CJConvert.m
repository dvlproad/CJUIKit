//
//  NSDictionary+CJConvert.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/31/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSDictionary+CJConvert.h"

@implementation NSDictionary (CJConvert)

///从服务器得到的JSON数据解析成NSDictionary后，通过递归遍历多维的NSDictionary可以方便的把字典中的所有键值输出出来方便测试检查。
- (NSString *)convertToString_byCycle{
    NSMutableString *str = [NSMutableString string];
    NSArray *keys = [self allKeys];
    for (NSString *key in keys) {
        id currentObject = [self objectForKey:key];
        if ([currentObject isKindOfClass:[NSDictionary class]]) {
            id obj = currentObject;
            [str appendFormat:@"\n%@: %@", key, [obj convertToString_byCycle]];
            
        }else if ([currentObject isKindOfClass:[NSArray class]]){
            [str appendFormat:@"\n%@:",key];
            for (id obj in currentObject) {
                [str appendFormat:@"\n%@",[obj convertToString_byCycle]];
            }
            
        }else{
            [str appendFormat:@"\n%@: %@",key,currentObject];
        }
    }
    return str;
}

@end
