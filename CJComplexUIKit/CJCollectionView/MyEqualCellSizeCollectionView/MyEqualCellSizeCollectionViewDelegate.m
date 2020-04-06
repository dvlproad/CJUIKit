//
//  MyEqualCellSizeCollectionViewDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionViewDelegate.h"

@interface MyEqualCellSizeCollectionViewDelegate () {
    
}
//必须设置的值
@property (nonatomic, strong, readonly) MyEqualCellSizeSetting *equalCellSizeSetting; /**< 集合视图的布局设置 */

///可选：点击Item要执行的方法
@property (nonatomic, copy) void (^didTapItemBlock)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect, MyEqualCellSizeSetting *equalCellSizeSetting); /**< 包括 didSelectItemAtIndexPath 和didDeselectItemAtIndexPath */

@end



@implementation MyEqualCellSizeCollectionViewDelegate

/**
 *  初始化delegate类
 *
 *  @param equalCellSizeSetting             集合视图的布局设置
 *  @param didTapItemBlock                         包括 didSelectItemAtIndexPath 和didDeselectItemAtIndexPath
 */
- (id)initWithEqualCellSizeSetting:(MyEqualCellSizeSetting *)equalCellSizeSetting
                   didTapItemBlock:(void (^)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect, MyEqualCellSizeSetting *equalCellSizeSetting))didTapItemBlock
{
    self = [super init];
    if (self) {
        _equalCellSizeSetting = equalCellSizeSetting;
        _didTapItemBlock = didTapItemBlock;
    }
    return self;
}


//*
#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
    UIEdgeInsets sectionInset = self.equalCellSizeSetting.sectionInset;
    return sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
//    return 15;
    CGFloat minimumLineSpacing = self.equalCellSizeSetting.minimumLineSpacing;
    return minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
//    return 10;
    CGFloat minimumInteritemSpacing = self.equalCellSizeSetting.minimumInteritemSpacing;
    return minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyEqualCellSizeSetting *equalCellSizeSetting = self.equalCellSizeSetting;
    
    CGFloat collectionViewCellWidth = 0;
    if (equalCellSizeSetting.cellWidthFromFixedWidth) {
        collectionViewCellWidth = equalCellSizeSetting.cellWidthFromFixedWidth;
        
    } else {
        NSInteger cellWidthFromPerRowMaxShowCount = equalCellSizeSetting.cellWidthFromPerRowMaxShowCount;
        
        UIEdgeInsets sectionInset = [self collectionView:collectionView
                                                  layout:collectionViewLayout
                                  insetForSectionAtIndex:indexPath.section];
        CGFloat minimumInteritemSpacing = [self collectionView:collectionView
                                                        layout:collectionViewLayout
                      minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        
        CGFloat width = CGRectGetWidth(collectionView.frame);
        CGFloat validWith = width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*(cellWidthFromPerRowMaxShowCount-1);
        collectionViewCellWidth = floorf(validWith/cellWidthFromPerRowMaxShowCount);
    }
    
    CGFloat collectionViewCellHeight = 0;
    if (equalCellSizeSetting.cellHeightFromFixedHeight) {
        collectionViewCellHeight = equalCellSizeSetting.cellHeightFromFixedHeight;
    } else if (equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount) {
        NSInteger cellHeightFromPerColumnMaxShowCount = equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount;
        
        UIEdgeInsets sectionInset = [self collectionView:collectionView
                                                  layout:collectionViewLayout
                                  insetForSectionAtIndex:indexPath.section];
        CGFloat minimumLineSpacing = [self collectionView:collectionView
                                                   layout:collectionViewLayout
                      minimumLineSpacingForSectionAtIndex:indexPath.section];
        
        CGFloat height = CGRectGetHeight(collectionView.frame);
        CGFloat validHeight = height - sectionInset.top - sectionInset.bottom - minimumLineSpacing*(cellHeightFromPerColumnMaxShowCount-1);
        collectionViewCellHeight = floorf(validHeight/cellHeightFromPerColumnMaxShowCount);
    } else {
        collectionViewCellHeight = collectionViewCellWidth;
    }
    
    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
}
//*/

//#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didTapItemBlock) {
        self.didTapItemBlock(collectionView, indexPath, NO, self.equalCellSizeSetting);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didTapItemBlock) {
        self.didTapItemBlock(collectionView, indexPath, YES, self.equalCellSizeSetting);
    }
}

#pragma mark - Update
/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting {
    _equalCellSizeSetting.extralItemSetting = extralItemSetting;
}


#pragma mark - Other
/*
 *  获取当前collectionView的高度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param equalCellSizeSetting     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForAllCellCount:(NSInteger)allCellCount
           byCollectionViewWidth:(CGFloat)collectionViewWidth
        withEqualCellSizeSetting:(MyEqualCellSizeSetting *)equalCellSizeSetting
{
    CGFloat minimumLineSpacing = equalCellSizeSetting.minimumLineSpacing;
    CGFloat minimumInteritemSpacing = equalCellSizeSetting.minimumInteritemSpacing;
    UIEdgeInsets sectionInset = equalCellSizeSetting.sectionInset;
    
    
    //计算cell的宽度
    CGFloat collectionViewCellWidth = 0;
    NSInteger perRowMaxShowCount = 0;
    if (equalCellSizeSetting.cellWidthFromFixedWidth) {
        collectionViewCellWidth = equalCellSizeSetting.cellWidthFromFixedWidth;
        
        //sectionInset.left + x*width + (x-1)*minimumInteritemSpacing + sectionInset.right <= collectionViewWidth;
        //x*cellWidth + (x-1)*minimumInteritemSpacing <= collectionViewWidth - sectionInset.left - sectionInset.right;
        //x*(cellWidth+minimumInteritemSpacing) <= collectionViewWidth - sectionInset.left - sectionInset.right + minimumInteritemSpacing;
        CGFloat validWidth = collectionViewWidth - sectionInset.left - sectionInset.right;
        perRowMaxShowCount = (validWidth+minimumInteritemSpacing)/(collectionViewCellWidth+minimumInteritemSpacing);
        
    } else {
        perRowMaxShowCount = equalCellSizeSetting.cellWidthFromPerRowMaxShowCount;
        NSAssert(perRowMaxShowCount != 0, @"perRowMaxShowCount不能为0");
        
        CGFloat validWidth = collectionViewWidth - sectionInset.left - sectionInset.right;
        CGFloat cellsWidth = validWidth - minimumInteritemSpacing*(perRowMaxShowCount-1);
        collectionViewCellWidth = floorf(cellsWidth/perRowMaxShowCount);
    }
    
    
    /* 获取cell的高度 */
    CGFloat collectionViewCellHeight = equalCellSizeSetting.cellHeightFromFixedHeight;
    if (collectionViewCellHeight <= 0) { //如果cell的高度未设置，我们默认使其等于cell的宽度
        collectionViewCellHeight = collectionViewCellWidth;
    }
    

    CGFloat height = 0;
    if (allCellCount == 0) {
        NSInteger currentRowCount = 0;
        height += currentRowCount * collectionViewCellHeight;
    } else {
        NSInteger currentRowCount = (allCellCount-1)/perRowMaxShowCount + 1;
        height += currentRowCount * collectionViewCellHeight + (currentRowCount - 1)*minimumLineSpacing;
    }
    height += sectionInset.top + sectionInset.bottom;
    
    return height;
}

@end
