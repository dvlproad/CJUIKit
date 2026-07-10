//
//  CJDataUtil+SortOrder.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil+SortOrder.h"

#import "CJDataUtil+Value.h"

@implementation CJDataUtil (SortOrder)

/** 完整的描述请参见文件头部 */
+ (NSArray *)sortOrderInDataArray:(NSArray *)sortedDataSource
                 withDataSelector:(SEL)dataSelector
            pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    NSAssert([sortedDataSource isKindOfClass:[NSArray class]], @"[sortedDataSource isKindOfClass:[NSArray class]]不符合");
    NSAssert(pinyinFromStringBlock, @"字符串转换成拼音的方法/方法不能为空");
    
    NSArray *sortedResultOrderArray = [sortedDataSource sortedArrayUsingComparator:^NSComparisonResult(id dataModel1, id dataModel2) {
        
        NSString *sortedString1 = [CJDataUtil stringValueForDataSelector:dataSelector inDataModel:dataModel1];
        NSString *pinyinString1 = pinyinFromStringBlock(sortedString1);
        NSString *pinyinString1uppercaseString = [pinyinString1 uppercaseString];
        
        NSString *sortedString2 = [CJDataUtil stringValueForDataSelector:dataSelector inDataModel:dataModel2];
        NSString *pinyinString2 = pinyinFromStringBlock(sortedString2);
        NSString *pinyinString2uppercaseString = [pinyinString2 uppercaseString];
        
        return [pinyinString1uppercaseString caseInsensitiveCompare:pinyinString2uppercaseString];
    }];
    
    return sortedResultOrderArray;
}

@end
