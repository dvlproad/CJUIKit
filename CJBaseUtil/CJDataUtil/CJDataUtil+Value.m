//
//  CJDataUtil+Value.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil+Value.h"

@implementation CJDataUtil (Value)

/* 完整的描述请参见文件头部 */
+ (NSString *)stringValueForDataSelector:(SEL)dataSelector inDataModel:(id)dataModel {
    NSString *resultValue = @"";
    if (dataSelector) {
        if([dataModel respondsToSelector:dataSelector])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            resultValue = [dataModel performSelector:dataSelector];
#pragma clang diagnostic pop
            
        }
    } else if ([dataModel isKindOfClass:[NSString class]]) {
        resultValue = dataModel;
        
    } else {
        
    }
    
    return resultValue;
}

/* 完整的描述请参见文件头部 */
+ (NSArray *)arrayValueForDataSelector:(SEL)dataSelector inDataModel:(id)dataModel {
    NSArray *resultArray = nil;
    if (dataSelector) {
        if([dataModel respondsToSelector:dataSelector])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            resultArray = [dataModel performSelector:dataSelector];
#pragma clang diagnostic pop
            
        }
    } else if ([dataModel isKindOfClass:[NSArray class]]) {
        resultArray = dataModel;
        
    } else {
        
    }
    
    return resultArray;
}


@end
