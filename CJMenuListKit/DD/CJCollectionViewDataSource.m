//
//  CJCollectionViewDataSource.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJCollectionViewDataSource.h"

@interface CJCollectionViewDataSource () {
    
}
@property (nonatomic, copy) UICollectionViewCell* (^cellForItemAtIndexPathBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);

@end



@implementation CJCollectionViewDataSource

- (id)init {
    return nil; //没有使用data初始化的时候，dataSoure类设为空，防止该类会执行一些不知道的方法
}

/*
 *  初始化dataSource类(初始化完之后，必须在之后设置想要展示的数据dataModels)
 *
 *  @param cellForItemAtIndexPathBlock          dataSource中的cell(含dataCell和extralCell)进行定制用的block
 */
- (id)initWithCellForItemAtIndexPathBlock:(UICollectionViewCell* (^)(UICollectionView *collectionView, NSIndexPath *indexPath))cellForItemAtIndexPathBlock
{
    self = [super init];
    if (self) {
        self.cellForItemAtIndexPathBlock = [cellForItemAtIndexPathBlock copy];      //block 要copy
    }
    return self;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger cellCount = [self __numberOfItemsInSection:section];
    return cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = self.cellForItemAtIndexPathBlock(collectionView, indexPath);
    
    return cell;
}


/**
*  dataSoure中indexPath位置的dataModel值
*
*  @param indexPath    collectionView的indexPath
*/
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath {
    id dataModle = [self.dataModels objectAtIndex:indexPath.item];
    
    return dataModle;
}


/**
*  获取指定section的item个数
*
*  @param section   指定的section
*
*  @return 整个cellCount的个数
*/
- (NSInteger)__numberOfItemsInSection:(NSInteger)section {
    NSInteger dataModelCount = self.dataModels.count;
    
    return dataModelCount;
}



@end
