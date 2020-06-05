//
//  CQCollectionViewFlowLayout.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQCollectionViewFlowLayout.h"

@implementation CQCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        //flowLayout.headerReferenceSize = CGSizeMake(110, 135);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 15;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
        _cellWidthFromPerRowMaxShowCount = 4;
        //_cellWidthFromFixedWidth = 50;
        
        //以下值，可选设置
        //_cellHeightFromFixedHeight = 30;
        //_cellHeightFromPerColumnMaxShowCount = 1;
        _widthHeightRatio = 1/1.0;
        
        //_maxDataModelShowCount = 5;
        //_extralItemSetting = CJExtralItemSettingLeading;
    }
    return self;
}


// 初始化
- (void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = [self __sizeForItemWithCollectionViewSize:self.collectionView.frame.size];;
}



////这个方法可以设置cell落在中间的位置
///*
// *  返回一个Point,让collectionView 停在这个点上
// *  @param proposedContentOffset collectionView 系统预计要停止的点
// *  @param velocity              速度
// */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
//}
//
///**
// *  @param rect 当前collctionView展示的区域
// *  @return 返回一个UICollectionViewLayoutAttributes数组,详情查看UICollectionViewLayoutAttributes各种属性
// */
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    return [super layoutAttributesForElementsInRect:rect];
//}
//
////返回YES 当CollectionView只要滚动就调用上面两个方法，默认返回NO,在适当的时候调用上面两个方法
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}


#pragma mark - Private Method
- (CGSize)__sizeForItemWithCollectionViewSize:(CGSize)collectionViewSize
{
    CGFloat collectionViewCellWidth = 0;
    if (self.cellWidthFromFixedWidth > 0) {
        collectionViewCellWidth = self.cellWidthFromFixedWidth;
        
    } else if (self.cellWidthFromPerRowMaxShowCount > 0) {
        NSInteger cellWidthFromPerRowMaxShowCount = self.cellWidthFromPerRowMaxShowCount;
        
        UIEdgeInsets sectionInset = self.sectionInset;
        CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
        
        CGFloat width = collectionViewSize.width;
        CGFloat validWith = width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*(cellWidthFromPerRowMaxShowCount-1);
        collectionViewCellWidth = floorf(validWith/cellWidthFromPerRowMaxShowCount);
    }
    
    CGFloat collectionViewCellHeight = 0;
    if (self.cellHeightFromFixedHeight > 0) {
        collectionViewCellHeight = self.cellHeightFromFixedHeight;
    } else if (self.cellHeightFromPerColumnMaxShowCount > 0) {
        NSInteger cellHeightFromPerColumnMaxShowCount = self.cellHeightFromPerColumnMaxShowCount;
        
        UIEdgeInsets sectionInset = self.sectionInset;
        CGFloat minimumLineSpacing = self.minimumLineSpacing;
        
        CGFloat height = collectionViewSize.height;
        CGFloat validHeight = height - sectionInset.top - sectionInset.bottom - minimumLineSpacing*(cellHeightFromPerColumnMaxShowCount-1);
        collectionViewCellHeight = floorf(validHeight/cellHeightFromPerColumnMaxShowCount);
    }
    
    NSAssert(collectionViewCellWidth > 0 || collectionViewCellHeight > 0, @"collectionViewCell 的 width 与 height 不能都未设置");
    if (collectionViewCellWidth > 0 && collectionViewCellHeight > 0) {
        NSLog(@"collectionViewCell 的 width 与 height 已设置完毕");
        return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
    }
    
    NSAssert(self.widthHeightRatio > 0, @"在只设置宽或高时，需要由比例来计算另一个值，所以比例值必须大于0");
    if (collectionViewCellWidth > 0) {
        collectionViewCellHeight = collectionViewCellWidth/self.widthHeightRatio;
    } else {
        collectionViewCellWidth = collectionViewCellHeight*self.widthHeightRatio;
    }
    
    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
}



#pragma mark - Other Method
/*
 *  获取当前collectionView的高度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param maxRowCount              允许的最大行数
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForAllCellCount:(NSInteger)allCellCount
                     maxRowCount:(NSInteger)maxRowCount
           byCollectionViewWidth:(CGFloat)collectionViewWidth
        withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout
{
    CGFloat minimumLineSpacing      = collectionViewLayout.minimumLineSpacing;
    CGFloat minimumInteritemSpacing = collectionViewLayout.minimumInteritemSpacing;
    UIEdgeInsets sectionInset       = collectionViewLayout.sectionInset;

    //计算cell的宽度
    CGSize collectionViewCellSize = [collectionViewLayout __sizeForItemWithCollectionViewSize:CGSizeMake(collectionViewWidth, 0)];
    CGFloat collectionViewCellWidth = collectionViewCellSize.width;
    CGFloat collectionViewCellHeight = collectionViewCellSize.height;
    NSInteger perRowMaxShowCount = 0;
    if (collectionViewLayout.cellHeightFromPerColumnMaxShowCount) {
        CGFloat validWidth = collectionViewWidth - sectionInset.left - sectionInset.right;
        perRowMaxShowCount = (validWidth+minimumInteritemSpacing)/(collectionViewCellWidth+minimumInteritemSpacing);
    } else {
        perRowMaxShowCount = collectionViewLayout.cellWidthFromPerRowMaxShowCount;
    }

    CGFloat height = 0;
    if (allCellCount == 0) {
        NSInteger currentRowCount = 0;
        height += currentRowCount * collectionViewCellHeight;
    } else {
        NSInteger currentRowCount = (allCellCount-1)/perRowMaxShowCount + 1;
        currentRowCount = MIN(currentRowCount, maxRowCount);
        height += currentRowCount * collectionViewCellHeight + (currentRowCount - 1)*minimumLineSpacing;
    }
    height += sectionInset.top + sectionInset.bottom;
    
    return height;
}

@end
