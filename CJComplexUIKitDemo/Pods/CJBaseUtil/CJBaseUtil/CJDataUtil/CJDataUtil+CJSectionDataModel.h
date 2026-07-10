//
//  CJDataUtil+CJSectionDataModel.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/06/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDataUtil.h"

#import <UIKit/UIKit.h>
#import "CJSectionDataModel.h"

@interface CJDataUtil (CJSectionDataModel)

/**
 *  统计从fromIndexPath到toIndexPath中的所有indexPath
 *
 *  @param fromIndexPath        开始选择的indexPath
 *  @param endIndexPath         结束选择的indexPath
 *  @param sectionDataModels    数据源
 *
 *  return  选择indexPaths
 */
+ (NSMutableArray<NSIndexPath *> *)statisticsIndexPathsFromIndexPath:(NSIndexPath *)fromIndexPath
                                                      toEndIndexPath:(NSIndexPath *)endIndexPath
                                                 inSectionDataModels:(NSMutableArray<CJSectionDataModel *> *)sectionDataModels;

/**
 *  判断是否是向后选择
 *
 *  @param fromIndexPath        开始选择的indexPath
 *  @param endIndexPath         结束选择的indexPath
 *
 *  return  返回YES代表是向后选择，NO代表向前选择
 */
+ (BOOL)checkIsBackwardsSelectionByFromIndexPath:(NSIndexPath *)fromIndexPath
                                  toEndIndexPath:(NSIndexPath *)endIndexPath;

/**
 *  比较fromIndexPath和endIndexPath的大小
 *
 *  @param fromIndexPath        开始选择的indexPath
 *  @param endIndexPath         结束选择的indexPath
 *
 *  return  NSOrderedAscending, NSOrderedSame 和 NSOrderedDescending
 */
+ (NSComparisonResult)compareFromIndexPath:(NSIndexPath *)fromIndexPath
                              endIndexPath:(NSIndexPath *)endIndexPath;


@end
