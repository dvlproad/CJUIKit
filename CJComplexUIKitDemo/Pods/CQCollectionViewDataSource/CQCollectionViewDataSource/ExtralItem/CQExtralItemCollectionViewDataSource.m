//
//  CQExtralItemCollectionViewDataSource.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQExtralItemCollectionViewDataSource.h"

@interface CQExtralItemCollectionViewDataSource () {
    NSInteger _currentPrefixCellIndex;  /**< 当前 prefixCell 的索引，如果为-1，代表当前不存在 */
    NSInteger _currentSuffixCellIndex;  /**< 当前 suffixCell 的索引，如果为-1，代表当前不存在 */
    NSInteger _currentCellCount;        /**< 当前cell总数(含头或尾等所有的) */
}
@property (nonatomic, copy) CQPreSufItemCellAtIndexPathBlock cellForPrefixBlock;
@property (nonatomic, copy) CQPreSufItemCellAtIndexPathBlock cellForSuffixBlock;
@property (nonatomic, copy) CQPreSufItemCellAtIndexPathBlock cellForItemBlock;

@end



@implementation CQExtralItemCollectionViewDataSource

- (id)init {
    return nil; //没有使用data初始化的时候，dataSoure类设为空，防止该类会执行一些不知道的方法
}

/*
 *  初始化dataSource类(初始化完之后，必须在之后设置想要展示的数据dataModels)
 *
 *  @param maxDataModelShowCount        最大显示的dataModel数目
 *  @param cellForPrefixBlock           头部prefixCell定制用的block
 *  @param cellForSuffixBlock           尾部suffixCell定制用的block
 *  @param cellForItemBlock             数据cell定制用的block
 */
- (id)initWithMaxShowCount:(NSUInteger)maxDataModelShowCount
        cellForPrefixBlock:(CQPreSufItemCellAtIndexPathBlock)cellForPrefixBlock
        cellForSuffixBlock:(CQPreSufItemCellAtIndexPathBlock)cellForSuffixBlock
          cellForItemBlock:(CQPreSufItemCellAtIndexPathBlock)cellForItemBlock
{
    self = [super init];
    if (self) {
        _maxDataModelShowCount = maxDataModelShowCount;
        
        self.cellForPrefixBlock = cellForPrefixBlock;
        _currentPrefixCellIndex = -1;
        self.cellForSuffixBlock = cellForSuffixBlock;
        _currentSuffixCellIndex = -1;

        self.cellForItemBlock = [cellForItemBlock copy];      //block 要copy
    }
    return self;
}

#pragma mark - Setter
- (void)setDataModels:(NSArray *)dataModels {
    // 数据
    _dataModels = dataModels;
}

- (void)__notifierDataModelCountChange {
    NSInteger itemCount = self.dataModels.count;
    
    // 获取所有 cell 的总数
    _currentCellCount = itemCount;
    if (self.cellForPrefixBlock && _currentCellCount < self.maxDataModelShowCount) {
        _currentPrefixCellIndex = 0;
        _currentCellCount++;
    } else {
        _currentPrefixCellIndex = -1;
    }
    
    if (self.cellForSuffixBlock && _currentCellCount < self.maxDataModelShowCount) {
        _currentSuffixCellIndex = _currentCellCount;
        _currentCellCount++;
    } else {
        _currentSuffixCellIndex = -1;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    [self __notifierDataModelCountChange];
    
    return _currentCellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _currentPrefixCellIndex) {
        return self.cellForPrefixBlock(self, collectionView, indexPath);
    }
    if (indexPath.row == _currentSuffixCellIndex) {
        return self.cellForSuffixBlock(self, collectionView, indexPath);
    }
    
    NSInteger itemIndex;
    if (_currentPrefixCellIndex == -1) { // 如果当前不存在PrefixCell
        itemIndex = indexPath.row;
    } else {
        itemIndex = indexPath.row - 1;
    }
    id dataModel = [self.dataModels objectAtIndex:itemIndex];
    
    UICollectionViewCell *itemCell = self.cellForItemBlock(self, collectionView, indexPath);
    return itemCell;
}


///删除第几张图片
- (BOOL)deletePhotoAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger itemIndex = [self itemIndexByIndexPath:indexPath];
    [self.dataModels removeObjectAtIndex:itemIndex];
    [self __notifierDataModelCountChange];
    return YES;
}



/*
*  IndexPath 位置的 itemIndex 是多少(如果为-1，则代表不是item的位置)
*
*  @param indexPath    collectionView的indexPath
*/
- (NSInteger)itemIndexByIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemIndex;
    
    if (indexPath.row == _currentPrefixCellIndex) {
        return -1;
    }
    if (indexPath.row == _currentSuffixCellIndex) {
        return -1;
    }
    
    if (_currentPrefixCellIndex == -1) { // 如果当前不存在PrefixCell
        itemIndex = indexPath.row;
    } else {
        itemIndex = indexPath.row - 1;
    }
    
    return itemIndex;
}

/*
 *  dataSoure中indexPath位置的dataModel值
 *
 *  @param indexPath    tableView的indexPath
 */
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemIndex = [self itemIndexByIndexPath:indexPath];
    
    id dataModel = [self.dataModels objectAtIndex:itemIndex];
    
    return dataModel;
}

@end
