//
//  CJDataUtil+CJSectionDataModel.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil+CJSectionDataModel.h"

@implementation CJDataUtil (CJSectionDataModel)

/* 完整的描述请参见文件头部 */
+ (NSMutableArray<NSIndexPath *> *)statisticsIndexPathsFromIndexPath:(NSIndexPath *)fromIndexPath
                                                      toEndIndexPath:(NSIndexPath *)endIndexPath
                                                 inSectionDataModels:(NSMutableArray<CJSectionDataModel *> *)sectionDataModels
{
    NSMutableArray<NSIndexPath *> *selectedIndexPaths = [[NSMutableArray alloc] init];
    
    NSInteger selectFromSection = fromIndexPath.section;
    NSInteger selectEndSection = endIndexPath.section;
    
    
    if (selectEndSection > selectFromSection) { //向后选择(已包括向下),用for语句中用“++”
        NSInteger minSection = selectFromSection;
        NSInteger maxSection = selectEndSection;
        
        for (NSInteger section = minSection; section < maxSection; section++) {
            CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:section];
            NSArray *dataModels = sectionDataModel.values;
            
            NSInteger minItem = -1;
            NSInteger maxItem = - 1;
            if (section == selectFromSection) {
                minItem = fromIndexPath.item;
                maxItem = dataModels.count - 1;
                
            } else if (section < selectEndSection) {
                minItem = 0;
                maxItem = endIndexPath.item;
            } else {
                minItem = 0;
                maxItem = dataModels.count - 1;
            }
            
            for (NSInteger item = minItem; item <= maxItem; item++) { //别漏了<=中的等号
                NSIndexPath *changeIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
                [selectedIndexPaths addObject:changeIndexPath];
            }
        }
        
    } else if (selectEndSection == selectFromSection) { //有可能向上；也有可能向下；也有可能不向上也不向下,而是向前或向后
        //CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:selectFromSection];
        //NSArray *dataModels = sectionDataModel.values;
        
        NSInteger minItem = -1;
        NSInteger maxItem = -1;
        
        if (endIndexPath.item > fromIndexPath.item) {
            minItem = fromIndexPath.item;
            maxItem = endIndexPath.item;
            
        } else if (endIndexPath.item == fromIndexPath.item) {
            minItem = fromIndexPath.item;
            maxItem = endIndexPath.item;
            
        } else {
            minItem = endIndexPath.item;
            maxItem = fromIndexPath.item;
        }
        
        for (NSInteger item = minItem; item <= maxItem; item++) {
            NSIndexPath *changeIndexPath = [NSIndexPath indexPathForItem:item inSection:selectFromSection];
            [selectedIndexPaths addObject:changeIndexPath];
        }
        
    } else { //向前选择(已包括向上)，用for语句中用“--”
        NSInteger maxSection = selectFromSection;
        NSInteger minSection = selectEndSection;
        
        for (NSInteger section = maxSection; section < minSection; section--) {
            CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:section];
            NSArray *dataModels = sectionDataModel.values;
            
            NSInteger maxItem = -1;
            NSInteger minItem = - 1;
            if (section == selectFromSection) {
                maxItem = fromIndexPath.item;
                minItem = 0;
                
            } else if (section < selectEndSection) {
                maxItem = endIndexPath.item;
                minItem = 0;
            } else {
                maxItem = dataModels.count - 1;
                minItem = endIndexPath.item;
            }
            
            for (NSInteger item = maxItem; item <= minItem; item--) {
                NSIndexPath *changeIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
                [selectedIndexPaths addObject:changeIndexPath];
            }
        }
    }
    
    return selectedIndexPaths;
}



/**
 *  判断是否是向后选择
 *
 *  @param fromIndexPath        开始选择的indexPath
 *  @param endIndexPath         结束选择的indexPath
 *
 *  return  返回YES代表是向后选择，NO代表向前选择
 */
+ (BOOL)checkIsBackwardsSelectionByFromIndexPath:(NSIndexPath *)fromIndexPath
                                  toEndIndexPath:(NSIndexPath *)endIndexPath {
    NSComparisonResult comparisonResult = [self compareFromIndexPath:fromIndexPath
                                                        endIndexPath:endIndexPath];
    if (comparisonResult == NSOrderedAscending ||
        comparisonResult == NSOrderedSame) {
        return YES;
        
    } else { //NSOrderedDescending
        return NO;
    }
}

/* 完整的描述请参见文件头部 */
+ (NSComparisonResult)compareFromIndexPath:(NSIndexPath *)fromIndexPath
                              endIndexPath:(NSIndexPath *)endIndexPath
{
    return [fromIndexPath compare:endIndexPath]; //系统的最简单方法
    
    /*
    //自己写的方法
    NSInteger selectFromSection = fromIndexPath.section;
    NSInteger selectEndSection = endIndexPath.section;
    
    
    if (selectEndSection > selectFromSection) { //向后选择(已包括向下),用for语句中用“++”
        return NSOrderedAscending;
        
    } else if (selectEndSection == selectFromSection) { //有可能向上；也有可能向下；也有可能不向上也不向下,而是向前或向后
        if (endIndexPath.item > fromIndexPath.item) {
            return NSOrderedAscending;
            
        } else if (endIndexPath.item == fromIndexPath.item) {
            return NSOrderedSame;
            
        } else {
            return NSOrderedDescending;
        }
        
    } else { //向前选择(已包括向上)，用for语句中用“--”
        return NSOrderedDescending;
    }
    //*/
}


@end
