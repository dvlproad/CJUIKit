//
//  CQCollectionViewFlowLayout.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQCollectionViewFlowLayout.h"

@interface CQCollectionViewFlowLayout () {
    
}
@property (nonatomic, assign, readonly) CGFloat columnSpacing;  /**<  水平列间距 */
@property (nonatomic, assign, readonly) CGFloat rowSpacing;     /**<  竖直行间距 */

@end

@implementation CQCollectionViewFlowLayout

/// 水平列间距
- (CGFloat)columnSpacing {
    CGFloat columnSpacing = self.minimumInteritemSpacing;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        columnSpacing = self.minimumLineSpacing;
    }
    return columnSpacing;
}

/// 竖直行间距
- (CGFloat)rowSpacing {
    CGFloat rowSpacing = self.minimumLineSpacing;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        rowSpacing = self.minimumInteritemSpacing;
    }
    return rowSpacing;;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //flowLayout.headerReferenceSize = CGSizeMake(110, 135);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 15;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
        //_cellWidthFromPerRowMaxShowCount = 4;
        //_cellWidthFromFixedWidth = 50;
        
        //以下值，可选设置
        //_cellHeightFromFixedHeight = 30;
        //_cellHeightFromPerColumnMaxShowCount = 1;
        _widthHeightRatio = 1/1.0;
    }
    return self;
}


// 初始化
- (void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = [self __sizeForItemWithCollectionViewSize:self.collectionView.frame.size];
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
        
    } else if (self.cellWidthFromPerRowMaxShowCount > 0 && collectionViewSize.width > 0) {
        // 每行最大列数
        NSInteger perRowMaxColumnCount = self.cellWidthFromPerRowMaxShowCount;
        
        UIEdgeInsets sectionInset = self.sectionInset;
        CGFloat columnSpacing = self.columnSpacing; // 水平列间距
        CGFloat width = collectionViewSize.width;
        CGFloat validWith = width - sectionInset.left - sectionInset.right - columnSpacing*(perRowMaxColumnCount-1);
        collectionViewCellWidth = floorf(validWith/perRowMaxColumnCount);
    }
    
    CGFloat collectionViewCellHeight = 0;
    if (self.cellHeightFromFixedHeight > 0) {
        collectionViewCellHeight = self.cellHeightFromFixedHeight;
    } else if (self.cellHeightFromPerColumnMaxShowCount > 0 && collectionViewSize.height > 0) {
        NSInteger perColumnMaxRowCount = self.cellHeightFromPerColumnMaxShowCount;
        
        UIEdgeInsets sectionInset = self.sectionInset;
        CGFloat rowSpacing = self.rowSpacing;
        
        CGFloat height = collectionViewSize.height;
        CGFloat validHeight = height - sectionInset.top - sectionInset.bottom - rowSpacing*(perColumnMaxRowCount-1);
        collectionViewCellHeight = floorf(validHeight/perColumnMaxRowCount);
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



#pragma mark - Other Method Get Height
/*
 *  获取当前collectionView的高度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param maxRowCount              允许的最大行数(即超过的部分需要滚动，若要计算全部高展开的高度，则此值用NSIntegerMax)
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
    // 计算cell的大小
    CGSize collectionViewCellSize = [collectionViewLayout __sizeForItemWithCollectionViewSize:CGSizeMake(collectionViewWidth, 0)];
    
    // 计算每行最大显示的item个数
    CGFloat collectionViewCellWidth = collectionViewCellSize.width;
    NSInteger maxColumnCountPerRow =
        [self maxColumnCountInCollectionViewWidth:collectionViewWidth
                          collectionViewCellWidth:collectionViewCellWidth
                         withCollectionViewLayout:collectionViewLayout];

    // 当前 items 所占的行数
    NSInteger currentRowCount = 0;
    if (allCellCount > 0) {
        currentRowCount = (allCellCount-1)/maxColumnCountPerRow + 1;
        currentRowCount = MIN(currentRowCount, maxRowCount);
    }
    
    // 当前 items 所占的高度
    CGFloat collectionViewCellHeight = collectionViewCellSize.height;
    CGFloat height = [self heightForRowCount:currentRowCount
                    collectionViewCellHeight:collectionViewCellHeight
                    withCollectionViewLayout:collectionViewLayout];
    return height;
}

/*
 *  获取collectionViewWidth按collectionViewLayout布局时候，每行最大显示的item个数/列数
 *
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param collectionViewCellWidth  cell的宽度(此值由collectionViewWidth计算得来)
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 每行最大显示的item个数
 */
+ (NSInteger)maxColumnCountInCollectionViewWidth:(CGFloat)collectionViewWidth
                         collectionViewCellWidth:(CGFloat)collectionViewCellWidth
                        withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout
{
    // 计算每行最大显示的item个数
    NSInteger perRowMaxShowCount = 0;
    
    if (collectionViewLayout.cellHeightFromPerColumnMaxShowCount) {
        UIEdgeInsets sectionInset = collectionViewLayout.sectionInset;
        CGFloat columnSpacing = collectionViewLayout.columnSpacing; // 水平列间距
        
        CGFloat validWidth = collectionViewWidth - sectionInset.left - sectionInset.right;
        perRowMaxShowCount = (validWidth+columnSpacing)/(collectionViewCellWidth+columnSpacing);
    } else {
        perRowMaxShowCount = collectionViewLayout.cellWidthFromPerRowMaxShowCount;
    }
    
    return perRowMaxShowCount;
}

/*
 *  获取指定行数时候的collectionView高度
 *
 *  @param rowCount                 指定的最大行数
 *  @param collectionViewCellHeight cell的高度
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 指定行数时候的collectionView高度
 */
+ (CGFloat)heightForRowCount:(NSInteger)rowCount
    collectionViewCellHeight:(CGFloat)collectionViewCellHeight
    withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout
{
    CGFloat rowSpacing = collectionViewLayout.rowSpacing; // 竖直行间距
    UIEdgeInsets sectionInset = collectionViewLayout.sectionInset;

    CGFloat height = 0;
    if (rowCount == 0) {
        height += 0;
    } else {
        height += rowCount * collectionViewCellHeight + (rowCount - 1)*rowSpacing;
    }
    height += sectionInset.top + sectionInset.bottom;
    
    return height;
}


#pragma mark - Other Method Get Width
/*
 *  获取当前collectionView的宽度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param maxColumnCount           允许的最大列数(即超过的部分需要滚动，若要计算全部高展开的宽度，则此值用NSIntegerMax)
 *  @param collectionViewHeight     要传入的collectionView的高度
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)widthForAllCellCount:(NSInteger)allCellCount
                 maxColumnCount:(NSInteger)maxColumnCount
         byCollectionViewHeight:(CGFloat)collectionViewHeight
       withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout
{
    // 计算cell的大小
    CGSize collectionViewCellSize = [collectionViewLayout __sizeForItemWithCollectionViewSize:CGSizeMake(0, collectionViewHeight)];
    
    // 计算每列最大显示的item个数
    CGFloat collectionViewCellHeight = collectionViewCellSize.height;
    NSInteger perColumnMaxShowCount =
        [self maxRowCountInCollectionViewHeight:collectionViewHeight
                       collectionViewCellHeight:collectionViewCellHeight
                       withCollectionViewLayout:collectionViewLayout];

    // 当前 items 所占的列数
    NSInteger currentColumnCount = 0;
    if (allCellCount > 0) {
        currentColumnCount = (allCellCount-1)/perColumnMaxShowCount + 1;
        currentColumnCount = MIN(currentColumnCount, maxColumnCount);
    }
    
    // 当前 items 所占的宽度
    CGFloat collectionViewCellWidth = collectionViewCellSize.width;
    CGFloat width = [self widthForColumnCount:currentColumnCount
                      collectionViewCellWidth:collectionViewCellWidth
                     withCollectionViewLayout:collectionViewLayout];
    return width;
}

/*
 *  获取collectionViewHeight按collectionViewLayout布局时候，每列最大显示的item个数
 *
 *  @param collectionViewHeight     要传入的collectionView的高度
 *  @param collectionViewCellHeight cell的高度(此值由collectionViewHeight计算得来)
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 每列最大显示的item个数
 */
+ (NSInteger)maxRowCountInCollectionViewHeight:(CGFloat)collectionViewHeight
                      collectionViewCellHeight:(CGFloat)collectionViewCellHeight
                      withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout
{
    // 计算每列最大显示的item个数
    NSInteger perColumnMaxShowCount = 0;
    
    if (collectionViewLayout.cellHeightFromPerColumnMaxShowCount) {
        UIEdgeInsets sectionInset = collectionViewLayout.sectionInset;
        CGFloat rowSpacing = collectionViewLayout.rowSpacing; // 竖直行间距
        
        CGFloat validHeight = collectionViewHeight - sectionInset.top - sectionInset.bottom;
        perColumnMaxShowCount = (validHeight+rowSpacing)/(collectionViewCellHeight+rowSpacing);
    } else {
        perColumnMaxShowCount = collectionViewLayout.cellHeightFromPerColumnMaxShowCount;
    }
    
    return perColumnMaxShowCount;
}

/*
 *  获取指定列数时候的collectionView宽度
 *
 *  @param columnCount              指定的最大列数
 *  @param collectionViewCellWidth  cell的宽度
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 指定列数时候的collectionView宽度
 */
+ (CGFloat)widthForColumnCount:(NSInteger)columnCount
       collectionViewCellWidth:(CGFloat)collectionViewCellWidth
      withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout
{
    CGFloat columnSpacing = collectionViewLayout.columnSpacing; // 水平列间距
    UIEdgeInsets sectionInset = collectionViewLayout.sectionInset;

    CGFloat width = 0;
    if (columnCount == 0) {
        width += 0;
    } else {
        width += columnCount * collectionViewCellWidth + (columnCount - 1)*columnSpacing;
    }
    width += sectionInset.left + sectionInset.right;
    
    return width;
}


@end
