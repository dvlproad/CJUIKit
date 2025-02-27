//
//  CQTSRipeBaseCollectionViewDataSource.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQDMSectionDataModel.h"
#import "CQTSLocImageDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeBaseCollectionViewDataSource : NSObject<UICollectionViewDataSource> {
    
}
@property (nonatomic, strong) NSArray<CQDMSectionDataModel *> *sectionDataModels;    /**< 每个section的数据 */

#pragma mark - Init
/*
 *  初始化 CollectionView 的 dataSource
 *
 *  @param sectionRowCounts             每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *  @param selectedIndexPaths             选中的indexPath数组
 *
 *  @return CollectionView 的 dataSource
 */
- (instancetype)initWithSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
                      selectedIndexPaths:(nullable NSArray<NSIndexPath *> *)selectedIndexPaths;
/*
 *  初始化 CollectionView 的 dataSource
 *
 *  @param sectionDataModels            每个section的数据(section中的数据元素必须是 CQTSLocImageDataModel )
 *
 *  @return CollectionView 的 dataSource
 */
- (instancetype)initWithSectionDataModels:(NSArray<CQDMSectionDataModel *> *)sectionDataModels NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/*
 *  注册 CollectionView 所需的所有 cell
 */
- (void)registerAllCellsForCollectionView:(UICollectionView *)collectionView;

/*
 *  获取指定位置的dataModel
 *
 *  @return 指定位置的dataModel
 */
- (CQTSLocImageDataModel *)dataModelAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
