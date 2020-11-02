//
//  CJImageAddDeleteCollectionViewDataSource.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJImageAddDeleteCollectionViewDataSource.h"

@interface CJImageAddDeleteCollectionViewDataSource () {
    NSInteger _currentPrefixCellIndex;  /**< 当前 prefixCell 的索引，如果为-1，代表当前不存在 */
    NSInteger _currentSuffixCellIndex;  /**< 当前 suffixCell 的索引，如果为-1，代表当前不存在 */
    NSInteger _currentCellCount;        /**< 当前cell总数(含头或尾等所有的) */
}
@property (nonatomic, assign, readonly) NSUInteger maxDataModelShowCount; /**< 集合视图最大显示的dataModel数目(默认NSIntegerMax即无限制) */
@property (nonatomic, copy) CQPreSufItemCellAtIndexPathBlock cellForPrefixBlock;
@property (nonatomic, copy) CQPreSufItemCellAtIndexPathBlock cellForSuffixBlock;
@property (nonatomic, copy) CQPreSufItemCellAtIndexPathBlock cellForItemBlock;
//@property (nonatomic, copy) NSInteger(^getItemCountBlock)(void);

@end



@implementation CJImageAddDeleteCollectionViewDataSource

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
 *  @param getItemCountBlock            获取item个数的回调
 */
- (id)initWithMaxShowCount:(NSUInteger)maxDataModelShowCount
        cellForPrefixBlock:(CQPreSufItemCellAtIndexPathBlock)cellForPrefixBlock
        cellForSuffixBlock:(CQPreSufItemCellAtIndexPathBlock)cellForSuffixBlock
          cellForItemBlock:(CQPreSufItemCellAtIndexPathBlock)cellForItemBlock
//         getItemCountBlock:(NSInteger(^)(void))getItemCountBlock
{
    self = [super init];
    if (self) {
        _maxDataModelShowCount = maxDataModelShowCount;
        
        self.cellForPrefixBlock = cellForPrefixBlock;
        _currentPrefixCellIndex = -1;
        self.cellForSuffixBlock = cellForSuffixBlock;
        _currentSuffixCellIndex = -1;

        self.cellForItemBlock = [cellForItemBlock copy];      //block 要copy
        
        self.dataModels = [[NSMutableArray alloc] init];
//        self.getItemCountBlock = getItemCountBlock;
    }
    return self;
}

/// 数据个数变为 itemCount 个
- (void)__notifierDataModelCountChange {
    NSInteger itemCount = self.dataModels.count;
//    NSAssert(self.getItemCountBlock != nil, @"获取item个数的回调不能为空");
//    NSInteger itemCount = self.getItemCountBlock();
    
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
    
    _currentCanMaxAddCount = _maxDataModelShowCount - itemCount;
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
    
    UICollectionViewCell *itemCell = self.cellForItemBlock(self, collectionView, indexPath);
    return itemCell;
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

///删除第几张图片
- (BOOL)deletePhotoAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger itemIndex = [self itemIndexByIndexPath:indexPath];
    [self.dataModels removeObjectAtIndex:itemIndex];
    return YES;
}

@end
