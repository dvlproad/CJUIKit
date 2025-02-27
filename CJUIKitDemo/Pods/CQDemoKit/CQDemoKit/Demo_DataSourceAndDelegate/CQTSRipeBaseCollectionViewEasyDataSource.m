//
//  CQTSRipeBaseCollectionViewEasyDataSource.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSRipeBaseCollectionViewEasyDataSource.h"
#import <CQDemoKit/CJUIKitCollectionViewCell.h>

@interface CQTSRipeBaseCollectionViewEasyDataSource () <UICollectionViewDataSource> {
    
}
@property (nonatomic, strong) NSArray<NSNumber *> *sectionRowCounts;    /**< 每个section的rowCount个数 */

@property (nonatomic, copy, readonly) void(^cellAtIndexPathConfigBlock)(UICollectionViewCell *bCollectionViewCell, NSIndexPath *bIndexPath); /**< 绘制指定indexPath的cell */

@end


@implementation CQTSRipeBaseCollectionViewEasyDataSource

#pragma mark - Init
/*
 *  初始化 CollectionView 的 dataSource
 *
 *  @param sectionRowCounts             每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *  @param cellForItemAtIndexPathBlock  对指定indexPath的cell进行设置
 *
 *  @return CollectionView 的 dataSource
 */
- (instancetype)initWithSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
              cellAtIndexPathConfigBlock:(void(^)(UICollectionViewCell *bCollectionViewCell, NSIndexPath *bIndexPath))cellAtIndexPathConfigBlock
{
    self = [super init];
    if (self) {
        _cellAtIndexPathConfigBlock = cellAtIndexPathConfigBlock;
        
        self.sectionRowCounts = sectionRowCounts;
    }
    return self;
}

/*
 *  注册 CollectionView 所需的所有 cell
 */
- (void)registerAllCellsForCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[CJUIKitCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionRowCounts.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSNumber *nRowCount = [self.sectionRowCounts objectAtIndex:section];
    NSInteger iRowCount = [nRowCount integerValue];
    
    return iRowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    !self.cellAtIndexPathConfigBlock ?: self.cellAtIndexPathConfigBlock(cell, indexPath);
    
    return cell;
}

@end
