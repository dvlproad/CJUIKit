//
//  CQTSRipeBaseCollectionViewDataSource.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSRipeBaseCollectionViewDataSource.h"
#import "UIImageView+CQTSBaseUtil.h"
#import "CQTSLocImagesUtil.h"

@interface CQTSRipeBaseCollectionViewDataSource () {
    
}

@property (nonatomic, copy, readonly) UICollectionViewCell *(^cellForItemAtIndexPathBlock)(UICollectionView *bCollectionView, NSIndexPath *bIndexPath, CQTSLocImageDataModel *dataModel); /**< 绘制指定indexPath的cell */

@end


@implementation CQTSRipeBaseCollectionViewDataSource

#pragma mark - Init
/*
 *  初始化 CollectionView 的 dataSource
 *
 *  @param sectionDataModels            每个section的数据(section中的数据元素必须是 CQDMModuleModel )
 *  @param registerHandler              集合视图cell等的注册
 *  @param cellForItemAtIndexPath       获取指定indexPath的cell
 *
 *  @return CollectionView 的 dataSource
 */
- (instancetype)initWithSectionDataModels:(NSArray<CQDMSectionDataModel *> *)sectionDataModels
                          registerHandler:(void(^)(void))registerHandler
                   cellForItemAtIndexPath:(UICollectionViewCell *(^)(UICollectionView *bCollectionView, NSIndexPath *bIndexPath, CQTSLocImageDataModel *dataModel))cellForItemAtIndexPath
{
    self = [super init];
    if (self) {
        _sectionDataModels = sectionDataModels;
        
        registerHandler();
        _cellForItemAtIndexPathBlock = cellForItemAtIndexPath;
    }
    return self;
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
    
    UICollectionViewCell *cell = self.cellForItemAtIndexPathBlock(collectionView, indexPath, moduleModel);

    return cell;
}


@end
