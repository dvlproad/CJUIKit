//
//  CQTSRipeSectionDataUtil.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSRipeSectionDataUtil.h"
#import "UIImageView+CQTSBaseUtil.h"
#import "CQTSLocImagesUtil.h"

@implementation CQTSRipeSectionDataUtil

#pragma mark - Init
/*
 *  获取 sectionModels
 *
 *  @param sectionRowCounts             每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *  @param selectedIndexPaths           选中的indexPath数组
 *
 *  @return sectionModels
 */
+ (NSMutableArray<CQDMSectionDataModel *> *)sectionModelsWithSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
                                                           selectedIndexPaths:(nullable NSArray<NSIndexPath *> *)selectedIndexPaths
{
    NSMutableArray<CQDMSectionDataModel *> *sectionDataModels = [[NSMutableArray alloc] init];
    for (int section = 0; section < sectionRowCounts.count; section++) {
        NSNumber *nRowCount = [sectionRowCounts objectAtIndex:section];
        NSInteger iRowCount = [nRowCount integerValue];
        
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = [NSString stringWithFormat:@"section %d", section];
        sectionDataModel.values = [CQTSLocImagesUtil imageModelsWithCount:iRowCount randomOrder:NO changeImageNameToNetworkUrl:NO];
        for (int item = 0; item < iRowCount; item++) {
            CQTSLocImageDataModel *module = [sectionDataModel.values objectAtIndex:item];
            module.name = [NSString stringWithFormat:@"%d-%02zd", section, item];
            
            BOOL isSelected = [selectedIndexPaths containsObject:[NSIndexPath indexPathForItem:item inSection:section]];
            module.selected = isSelected;
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    return sectionDataModels;
}


/*
 *  获取 sectionModels
 *
 *  @param buttonTitles                 按钮的标题数组
 *
 *  @return sectionModels
 */
+ (NSMutableArray<CQDMSectionDataModel *> *)sectionModelsWithTitles:(NSArray<NSString *> *)buttonTitles
{
    NSNumber *number = [NSNumber numberWithInteger:buttonTitles.count];
    NSArray<NSNumber *> *sectionRowCounts = @[number];
    
    return [self sectionModelsWithSectionRowCounts:sectionRowCounts selectedIndexPaths:nil];
}
@end
