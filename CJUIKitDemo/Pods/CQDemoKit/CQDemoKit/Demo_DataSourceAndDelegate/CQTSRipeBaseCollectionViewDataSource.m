//
//  CQTSRipeBaseCollectionViewDataSource.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSRipeBaseCollectionViewDataSource.h"
#import "CJUIKitCollectionViewCell.h"
#import "UIImageView+CQTSBaseUtil.h"
#import "CQTSLocImagesUtil.h"

@interface CQTSRipeBaseCollectionViewDataSource () {
    
}

@property (nonatomic, copy, readonly) void(^cellAtIndexPathConfigBlock)(UICollectionViewCell *bCollectionViewCell, NSIndexPath *bIndexPath); /**< 绘制指定indexPath的cell */

@end


@implementation CQTSRipeBaseCollectionViewDataSource

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
                      selectedIndexPaths:(nullable NSArray<NSIndexPath *> *)selectedIndexPaths
{
    NSMutableArray<CQDMSectionDataModel *> *sectionDataModels = [[NSMutableArray alloc] init];
    for (int section = 0; section < sectionRowCounts.count; section++) {
        NSNumber *nRowCount = [sectionRowCounts objectAtIndex:section];
        NSInteger iRowCount = [nRowCount integerValue];
        
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = [NSString stringWithFormat:@"section %d", section];
        sectionDataModel.values = [CQTSLocImagesUtil __getTestLocalImageDataModelsWithCount:iRowCount randomOrder:NO];
        for (int item = 0; item < iRowCount; item++) {
            CQTSLocImageDataModel *module = [sectionDataModel.values objectAtIndex:item];
            module.name = [NSString stringWithFormat:@"%d-%02zd", section, item];
            
            BOOL isSelected = [selectedIndexPaths containsObject:[NSIndexPath indexPathForItem:item inSection:section]];
            module.selected = isSelected;
//            CQTSLocImageDataModel *module = [[CQTSLocImageDataModel alloc] init];
//            module.title = [NSString stringWithFormat:@"%d-%02zd", section, item];
//            [sectionDataModel.values addObject:module];
        }
        [sectionDataModels addObject:sectionDataModel];
    }

    self = [self initWithSectionDataModels:sectionDataModels];
    if (self) {
        
    }
    return self;
}

/*
 *  初始化 CollectionView 的 dataSource
 *
 *  @param sectionDataModels            每个section的数据(section中的数据元素必须是 CQDMModuleModel )
 *
 *  @return CollectionView 的 dataSource
 */
- (instancetype)initWithSectionDataModels:(NSArray<CQTSLocImageDataModel *> *)sectionDataModels
{
    self = [super init];
    if (self) {
        _sectionDataModels = sectionDataModels;
    }
    return self;
}

/*
 *  注册 CollectionView 所需的所有 cell
 */
- (void)registerAllCellsForCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[CJUIKitCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

/*
 *  获取指定位置的dataModel
 *
 *  @return 指定位置的dataModel
 */
- (CQTSLocImageDataModel *)dataModelAtIndexPath:(NSIndexPath *)indexPath {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CQTSLocImageDataModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    return moduleModel;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionDataModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CQTSLocImageDataModel *moduleModel = [self dataModelAtIndexPath:indexPath];
    
    CJUIKitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = moduleModel.image;
    cell.textLabel.text = moduleModel.name;
    
    return cell;
}


@end
