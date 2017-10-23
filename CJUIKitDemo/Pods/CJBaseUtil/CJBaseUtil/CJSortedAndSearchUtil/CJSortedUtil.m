//
//  CJSortedUtil.m
//  CJBaseViewControllerDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSortedUtil.h"
#import "CJDataModelUtil.h"
#import "CJPinyinHelper.h"

@implementation CJSortedUtil

/** 完整的描述请参见文件头部 */
+ (CJSortedCategoryResult *)sortCategoryPinyinInDataArray:(NSArray *)sortedDataSource
                                 withDataSelector:(SEL)dataSelector
                                       andOrderIt:(BOOL)order {
    CJSortedCategoryResult *sortedCategoryResult = [self sortCategoryByIndexs:nil
                                                                  inDataArray:sortedDataSource
                                                             withDataSelector:dataSelector
                                                                   andOrderIt:YES];
    
    return sortedCategoryResult;
}


/**
 *  对数组进行分组
 *
 *  @param indexTitles      indexTitles
 *  @param sortedDataSource 要分组的数据(数组的元素可以为自定义类，也可以为NSString)
 *  @param dataSelector     根据数据中的哪个字段进行分组
 *  @param order            是否根据对分组后的每组进行排序
 *
 *  return 分组结果
 */
+ (CJSortedCategoryResult *)sortCategoryByIndexs:(NSMutableArray *)indexTitles
                                     inDataArray:(NSArray *)sortedDataSource
                                withDataSelector:(SEL)dataSelector
                                      andOrderIt:(BOOL)order {
    //建立索引的核心, 返回27，是a－z和＃
    indexTitles = [[NSMutableArray alloc] init];
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    NSArray *sectionTitles = [indexCollation sectionTitles];
    NSLog(@"sectionTitles = %@", sectionTitles);
    [indexTitles addObjectsFromArray:sectionTitles];
    
    NSArray *sectionIndexTitles = [indexCollation sectionIndexTitles];
    NSLog(@"sectionIndexTitles = %@", sectionIndexTitles);
    
    NSInteger highSection = [indexTitles count];
    NSMutableArray<NSMutableArray *> *sortedResultCategoryArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *categoryArray = [NSMutableArray arrayWithCapacity:1];
        [sortedResultCategoryArrays addObject:categoryArray];
    }
    
    //按首字母分组
    for (id dataModel in sortedDataSource) {
        NSString *sortedString = [CJDataModelUtil stringValueForDataSelector:dataSelector inDataModel:dataModel];
        sortedString = [sortedString lowercaseString];
        //if ([sortedString isEqualToString:@""]) {
        //    continue; //因为索引中没有@“”索引
        //}
        
        //排序判断
        NSString *pinyinString = [CJPinyinHelper pinyinFromChineseString:sortedString];
        NSString *firstLetter = [pinyinString substringToIndex:1];
        NSInteger section = [indexCollation sectionForObject:firstLetter collationStringSelector:@selector(uppercaseString)];
        
        NSMutableArray *array = [sortedResultCategoryArrays objectAtIndex:section];
        [array addObject:dataModel];
    }
    
    //去掉空的section
    for (NSInteger i = [sortedResultCategoryArrays count] - 1; i >= 0; i--) {
        NSArray *categoryArray = [sortedResultCategoryArrays objectAtIndex:i];
        if ([categoryArray count] == 0) {
            [sortedResultCategoryArrays removeObjectAtIndex:i];
            [indexTitles removeObjectAtIndex:i];
        }
    }
    
    CJSortedCategoryResult *sortedCategoryResult = [[CJSortedCategoryResult alloc] init];
    sortedCategoryResult.indexTitles = indexTitles;
    if (order == NO) {
        sortedCategoryResult.arrays = sortedResultCategoryArrays;
        
    } else {
        NSArray *sortedResultOrderArray = [CJSortedUtil sortedOrderInDataArray:sortedResultCategoryArrays withDataSelector:dataSelector];
        sortedCategoryResult.arrays = [NSMutableArray arrayWithArray:sortedResultOrderArray];
    }
    
    return sortedCategoryResult;
}

//+ (void)removeEmptyCategoryArrayInCategoryArrays:(NSArray *)categoryArrays {
//    
//}

/** 完整的描述请参见文件头部 */
+ (NSArray *)sortedOrderInDataArray:(NSArray *)sortedDataSource
                   withDataSelector:(SEL)dataSelector {
    NSAssert([sortedDataSource isKindOfClass:[NSArray class]], @"[sortedDataSource isKindOfClass:[NSArray class]]不符合");
    
    NSArray *sortedResultOrderArray = [sortedDataSource sortedArrayUsingComparator:^NSComparisonResult(id dataModel1, id dataModel2) {
        
        NSString *sortedString1 = [CJDataModelUtil stringValueForDataSelector:dataSelector inDataModel:dataModel1];
        NSString *pinyinString1 = [CJPinyinHelper pinyinFromChineseString:sortedString1];
        NSString *pinyinString1uppercaseString = [pinyinString1 uppercaseString];
        
        NSString *sortedString2 = [CJDataModelUtil stringValueForDataSelector:dataSelector inDataModel:dataModel2];
        NSString *pinyinString2 = [CJPinyinHelper pinyinFromChineseString:sortedString2];
        NSString *pinyinString2uppercaseString = [pinyinString2 uppercaseString];
        
        return [pinyinString1uppercaseString caseInsensitiveCompare:pinyinString2uppercaseString];
    }];
    
    return sortedResultOrderArray;
}

@end
