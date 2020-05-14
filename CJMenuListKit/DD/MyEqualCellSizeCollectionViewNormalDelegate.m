//
//  MyEqualCellSizeCollectionViewNormalDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionViewNormalDelegate.h"

@interface MyEqualCellSizeCollectionViewNormalDelegate () {
    
}

///可选：点击Item要执行的方法
@property (nonatomic, copy) void (^didTapItemBlock)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect); /**< 包括 didSelectItemAtIndexPath 和didDeselectItemAtIndexPath */

@end



@implementation MyEqualCellSizeCollectionViewNormalDelegate

/**
 *  初始化delegate类
 *
 *  @param flowLayout                                    集合视图的布局设置
 *  @param didTapItemBlock                         包括 didSelectItemAtIndexPath 和didDeselectItemAtIndexPath
 */
- (id)initWithFlowLayout:(CQCollectionViewFlowLayout *)flowLayout
         didTapItemBlock:(void (^)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect))didTapItemBlock
{
    self = [super init];
    if (self) {
        _didTapItemBlock = didTapItemBlock;
    }
    return self;
}


#pragma mark - UICollectionViewDelegateFlowLayout
// 此部分已在父类中实现
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return [super collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return [super collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return [super collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

//#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didTapItemBlock) {
        self.didTapItemBlock(collectionView, indexPath, NO);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didTapItemBlock) {
        self.didTapItemBlock(collectionView, indexPath, YES);
    }
}

@end
