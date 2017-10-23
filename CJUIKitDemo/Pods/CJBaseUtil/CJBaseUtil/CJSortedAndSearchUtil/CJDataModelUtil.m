//
//  CJDataModelUtil.m
//  CJBaseViewControllerDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataModelUtil.h"

@implementation CJDataModelUtil

/**
 *  取数组内元素对应属性值
 *
 *  @param dataSelector dataSelector为空的时候取自身
 *  @param dataModel    dataModel
 *
 *  return 数组内元素的属性值（dataSelector为空时，返回元素自身）
 */
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

/**
 *  取数组内元素对应属性值
 *
 *  @param dataSelector dataSelector为空的时候取自身
 *  @param dataModel    dataModel
 *
 *  return 数组内元素的属性值（dataSelector为空时，返回元素自身）
 */
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
