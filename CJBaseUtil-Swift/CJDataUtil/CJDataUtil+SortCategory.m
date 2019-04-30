//
//  CJDataUtil+SortCategory.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil+SortCategory.h"

#import "CJDataUtil+SortOrder.h"

#import "CJDataUtil+Value.h"

@implementation CJDataUtil (Sort)

/** 完整的描述请参见文件头部 */
+ (CJSortedCategoryResult *)sortCategoryPinyinInDataArray:(NSArray *)sortedDataSource
                                 withDataSelector:(SEL)dataSelector
                                       andOrderIt:(BOOL)order
                                    pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock
{
    CJSortedCategoryResult *sortedCategoryResult = [self sortCategoryByIndexs:nil
                                                                  inDataArray:sortedDataSource
                                                             withDataSelector:dataSelector
                                                                   andOrderIt:YES pinyinFromStringBlock:pinyinFromStringBlock];
    
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
                                      andOrderIt:(BOOL)order
                           pinyinFromStringBlock:(NSString *(^)(NSString *string))pinyinFromStringBlock {
    //建立索引的核心, 返回27，是a－z和＃
    UILocalizedIndexedCollation *localizedIndexedCollation = [UILocalizedIndexedCollation currentCollation];
    indexTitles = [self getIndexTitlesFromIndexedCollation:localizedIndexedCollation];
    
    NSInteger highSection = [indexTitles count];
    NSMutableArray<NSMutableArray *> *sortedResultCategoryArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *categoryArray = [NSMutableArray arrayWithCapacity:1];
        [sortedResultCategoryArrays addObject:categoryArray];
    }
    
    //按首字母分组
    for (id dataModel in sortedDataSource) {
        NSString *sortedString = [CJDataUtil stringValueForDataSelector:dataSelector inDataModel:dataModel];
        sortedString = [sortedString lowercaseString];
        //if ([sortedString isEqualToString:@""]) {
        //    continue; //因为索引中没有@“”索引
        //}
        
        //排序判断
        NSString *pinyinString = pinyinFromStringBlock(sortedString);
        NSString *firstLetter = [pinyinString substringToIndex:1];
        NSInteger section = [localizedIndexedCollation sectionForObject:firstLetter collationStringSelector:@selector(uppercaseString)];
        
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
        NSArray *sortOrderResults = [CJDataUtil sortOrderInDataArray:sortedResultCategoryArrays
                                                    withDataSelector:dataSelector
                                        pinyinFromStringBlock:pinyinFromStringBlock];
        sortedCategoryResult.arrays = [NSMutableArray arrayWithArray:sortOrderResults];
    }
    
    return sortedCategoryResult;
}

//+ (void)removeEmptyCategoryArrayInCategoryArrays:(NSArray *)categoryArrays {
//    
//}

/**
 *  建立默认的索引列表
 *
 *  return  返回是a－z和＃(共27个)
 */
+ (NSMutableArray<NSString *> *)getIndexTitlesFromIndexedCollation:(UILocalizedIndexedCollation *)localizedIndexedCollation {
    NSMutableArray *indexTitles = [[NSMutableArray alloc] init];
    NSArray *sectionTitles = [localizedIndexedCollation sectionTitles];
    NSLog(@"sectionTitles = %@", sectionTitles);
    [indexTitles addObjectsFromArray:sectionTitles];
    
    NSArray *sectionIndexTitles = [localizedIndexedCollation sectionIndexTitles];
    NSLog(@"sectionIndexTitles = %@", sectionIndexTitles);
    
    return indexTitles;
}



@end
