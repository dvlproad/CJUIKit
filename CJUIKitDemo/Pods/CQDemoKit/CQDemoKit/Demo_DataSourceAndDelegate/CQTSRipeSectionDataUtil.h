//
//  CQTSRipeSectionDataUtil.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQDMSectionDataModel.h"
#import "CQTSLocImageDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeSectionDataUtil : NSObject {
    
}
#pragma mark - Init
/*
 *  获取 sectionModels
 *
 *  @param fileExtensions               要获取哪些文件后缀的文件
 *  @param sectionRowCounts             每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *  @param selectedIndexPaths           选中的indexPath数组
 *
 *  @return sectionModels
 */
+ (NSMutableArray<CQDMSectionDataModel *> *)sectionModelsWithExtensions:(NSArray<NSString *> *)fileExtensions
                                                       sectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
                                                    selectedIndexPaths:(nullable NSArray<NSIndexPath *> *)selectedIndexPaths;

/*
 *  获取 sectionModels
 *
 *  @param buttonTitles                 按钮的标题数组
 *
 *  @return sectionModels
 */
+ (NSMutableArray<CQDMSectionDataModel *> *)sectionModelsWithTitles:(NSArray<NSString *> *)buttonTitles;

@end

NS_ASSUME_NONNULL_END
