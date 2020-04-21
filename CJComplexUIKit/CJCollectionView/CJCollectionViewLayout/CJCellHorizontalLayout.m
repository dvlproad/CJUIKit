//
//  CJCellHorizontalLayout.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16-5-30.
//  Copyright (c) 2016年 dvlproad. All rights reserved.
//

#import "CJCellHorizontalLayout.h"

@interface CJCellHorizontalLayout() {
    
}
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSMutableArray *leftArray;
@property (nonatomic, strong) NSMutableDictionary *heigthDic;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;
@property (nonatomic, strong) NSMutableArray *indexPathsToAnimate;

@property (nonatomic, assign, readonly) CGSize itemSize;                  /**< item大小 */

@end



@implementation CJCellHorizontalLayout
{
    NSInteger _maxRowPerPage;     /**< 每页最多有多少列 */
    NSInteger _maxColumnPerPage;  /**< 每页最多有多少列 */
    CGFloat _actualInteritemSpacing;/**< item之间的实际间隔 */
    CGFloat _actualLineSpacing;     /**< line之间的实际间隔 */
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftArray = [NSMutableArray new];
        self.heigthDic = [NSMutableDictionary new];
        self.attributes = [NSMutableArray new];
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout]; //需调用父类方法
    
    _itemSize = [self sizeForItem];
    CGFloat itemWidth = self.itemSize.width;
    CGFloat itemHeight = self.itemSize.height;
    
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat height = self.collectionView.frame.size.height;
    
    /* 计算最多列数column和item实际间隔actualInteritemSpacing */
    CGFloat contentWidth = (width - self.sectionInset.left - self.sectionInset.right);
    //x*(itemWidth+minimumInteritemSpacing) + itemWidth = contentWidth; //x间隙个数
    NSInteger gapCountPerRow = (contentWidth-itemWidth)/(itemWidth+self.minimumInteritemSpacing);
    NSInteger maxColumnPerPage = gapCountPerRow+1;
    CGFloat totalResidualIntervalPerRow = contentWidth - maxColumnPerPage*itemWidth;//每行剩余的总间隔
    CGFloat actualInteritemSpacing = totalResidualIntervalPerRow/(maxColumnPerPage-1);
    _maxColumnPerPage = maxColumnPerPage;
    _actualInteritemSpacing = actualInteritemSpacing;
    _actualInteritemSpacing = _minimumInteritemSpacing; //TODO:待修复，这里暂时直接取值

    /* 计算最多行数和line实际间隔actualLineSpacing */
    CGFloat contentHeight = (height - self.sectionInset.top - self.sectionInset.bottom);
    //x*(itemHeight+minimumLineSpacing) + itemHeight = contentHeight; //x间隙个数
    NSInteger gapCountPerColumn = (contentHeight-itemHeight)/(itemHeight+self.minimumLineSpacing);
    NSInteger maxRowPerPage = gapCountPerColumn+1;
    CGFloat totalResidualIntervalPerColumn = contentHeight - maxRowPerPage*itemHeight;//每列剩余的总间隔
    CGFloat actualLineSpacing = totalResidualIntervalPerColumn/(maxRowPerPage-1);
    _maxRowPerPage = maxRowPerPage;
    _actualLineSpacing = actualLineSpacing;
    _actualLineSpacing = _minimumLineSpacing;   //TODO:待修复，这里暂时直接取值
    
    int itemNumber = 0;
    itemNumber = itemNumber + (int)[self.collectionView numberOfItemsInSection:0];
    if (itemNumber >= 1) {
        pageNumber = (itemNumber - 1)/(_maxRowPerPage*_maxColumnPerPage) + 1; //每页6个，则6个时候也只有一页(6-1)/6+1
    } else {
        pageNumber = 1;
    }
}


- (CGSize)sizeForItem
{
    return [self sizeForItemWithCollectionViewSize:self.collectionView.frame.size];
}

- (CGSize)sizeForItemWithCollectionViewSize:(CGSize)collectionViewSize
{
    CGFloat collectionViewCellWidth = 0;
    if (self.cellWidthFromFixedWidth) {
        collectionViewCellWidth = self.cellWidthFromFixedWidth;
        
    } else {
        NSInteger cellWidthFromPerRowMaxShowCount = self.cellWidthFromPerRowMaxShowCount;
        
        UIEdgeInsets sectionInset = self.sectionInset;
        CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
        
        CGFloat width = collectionViewSize.width;
        CGFloat validWith = width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*(cellWidthFromPerRowMaxShowCount-1);
        collectionViewCellWidth = floorf(validWith/cellWidthFromPerRowMaxShowCount);
    }
    
    CGFloat collectionViewCellHeight = 0;
    if (self.cellHeightFromFixedHeight) {
        collectionViewCellHeight = self.cellHeightFromFixedHeight;
    } else if (self.cellHeightFromPerColumnMaxShowCount) {
        NSInteger cellHeightFromPerColumnMaxShowCount = self.cellHeightFromPerColumnMaxShowCount;
        
        UIEdgeInsets sectionInset = self.sectionInset;
        CGFloat minimumLineSpacing = self.minimumLineSpacing;
        
        CGFloat height = collectionViewSize.height;
        CGFloat validHeight = height - sectionInset.top - sectionInset.bottom - minimumLineSpacing*(cellHeightFromPerColumnMaxShowCount-1);
        collectionViewCellHeight = floorf(validHeight/cellHeightFromPerColumnMaxShowCount);
    } else {
        collectionViewCellHeight = collectionViewCellWidth;
    }
    
    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
}


//- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems
//{
//    [super prepareForCollectionViewUpdates:updateItems];
//    NSMutableArray *indexPaths = [NSMutableArray array];
//    for (UICollectionViewUpdateItem *updateItem in updateItems) {
//        switch (updateItem.updateAction) {
//            case UICollectionUpdateActionInsert:
//                [indexPaths addObject:updateItem.indexPathAfterUpdate];
//                break;
//            case UICollectionUpdateActionDelete:
//                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
//                break;
//            
//            case UICollectionUpdateActionMove:
//                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
//                [indexPaths addObject:updateItem.indexPathAfterUpdate];
//                break;
//        
//
//            default:
//                break;
//        }
//    }
//    self.indexPathsToAnimate = indexPaths;
//}

//- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    
//    if ([_indexPathsToAnimate containsObject:itemIndexPath]) {
//        attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
//        attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
//        [_indexPathsToAnimate removeObject:itemIndexPath];
//    }
//    
//    return attr;
//}

- (CGPoint)targetContentOffsetForProposedContentOffset: (CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity //自动对齐到网格
{
    //proposedContentOffset是没有对齐到网格时本来应该停下的位置
    CGFloat offsetY = MAXFLOAT;
    CGFloat offsetX = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + self.itemSize.width/2;
    CGFloat verticalCenter = proposedContentOffset.y + self.itemSize.height/2;
    CGRect targetRect = CGRectMake(0, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    CGPoint offPoint = proposedContentOffset;
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        CGFloat itemVerticalCenter = layoutAttributes.center.y;
        if (ABS(itemHorizontalCenter - horizontalCenter) && (ABS(offsetX)>ABS(itemHorizontalCenter - horizontalCenter))) {
            offsetX = itemHorizontalCenter - horizontalCenter;
            offPoint = CGPointMake(itemHorizontalCenter, itemVerticalCenter);
        }
        if (ABS(itemVerticalCenter - verticalCenter) && (ABS(offsetY)>ABS(itemVerticalCenter - verticalCenter))) {
            offsetY = itemHorizontalCenter - horizontalCenter;
            offPoint = CGPointMake(itemHorizontalCenter, itemVerticalCenter);
        }
    }
    return offPoint;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width*pageNumber, self.collectionView.bounds.size.height);
}


static long  pageNumber = 1;

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /* 计算每个cell的frame */
    NSInteger maxItemCountRowPerPage = _maxRowPerPage * _maxColumnPerPage; //每页最多item个数
    //先计算出item在第几页，及其在所在页中的行和列
    long pageIndexForItem = indexPath.item/maxItemCountRowPerPage; //①当前item在第几页
    
    NSInteger indexForItemInCurrentPage = 0;//②当前item在本页中属于第几个
    if (indexPath.item < maxItemCountRowPerPage) {
        indexForItemInCurrentPage = indexPath.item;
    } else {
        indexForItemInCurrentPage = indexPath.item%maxItemCountRowPerPage;
    }
    long rowIndexForItem = indexForItemInCurrentPage/_maxColumnPerPage; //item在其所在页中所在的行
    long columnIndexForItem = indexPath.item%_maxColumnPerPage;//③item在其所在页中所在的列
    
    
    CGFloat itemX = columnIndexForItem*self.itemSize.width+(columnIndexForItem)*_actualInteritemSpacing+self.sectionInset.left+(indexPath.section+pageIndexForItem)*self.collectionView.frame.size.width;
    CGFloat itemY = rowIndexForItem*self.itemSize.height + (rowIndexForItem)*_actualLineSpacing+self.sectionInset.top;
    
    //利用上面计算的所得值，得到frame
    CGRect frame;
    frame.size = self.itemSize;
    frame.origin = CGPointMake(itemX, itemY);
    
    attribute.frame = frame;
    return attribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *tmpAttributes = [NSMutableArray new];
    for (int j = 0; j < self.collectionView.numberOfSections; j ++)
    {
        NSInteger count = [self.collectionView numberOfItemsInSection:j];
        for (NSInteger i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            [tmpAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    self.attributes = tmpAttributes;
    return self.attributes;
    
    
}

//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha = 0.0;
////    attributes.center = CGPointMake(_center.x, _center.y);
//    return attributes;
//}

//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha = 0.0;
////    attributes.center = CGPointMake(_center.x, _center.y);
//    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
//    return attributes;
//}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return NO;
    //return !CGRectEqualToRect(self.collectionView.bounds, newBounds);
}



//- (NSIndexPath *)targetIndexPathForInteractivelyMovingItem:(NSIndexPath *)previousIndexPath withPosition:(CGPoint)position{
//    NSIndexPath *indexpath = [self.collectionView indexPathForItemAtPoint:position];
//    return indexpath;
//}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForInteractivelyMovingItemAtIndexPath:(NSIndexPath *)indexPath withTargetPosition:(CGPoint)position {
//    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForInteractivelyMovingItemAtIndexPath:indexPath withTargetPosition:position];
////    attributes.transform3D = CATransform3DMakeScale(1.2, 1.2, 1.0);
//    attributes.zIndex = 1;
//    NSLog(@"变大");
//    NSIndexPath *tmpPath = [self.collectionView indexPathForItemAtPoint:position];
//    if (tmpPath != indexPath) {
//        [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:tmpPath];
//    }
//    
//    return attributes;
//}

//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForInteractivelyMovingItems:(NSArray<NSIndexPath *> *)targetIndexPaths withTargetPosition:(CGPoint)targetPosition previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths previousPosition:(CGPoint)previousPosition {
//    UICollectionViewLayoutInvalidationContext* context = [super invalidationContextForInteractivelyMovingItems:targetIndexPaths withTargetPosition:targetPosition previousIndexPaths:previousIndexPaths previousPosition:previousPosition];
//   
//    return context;
//}
//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:(NSArray<NSIndexPath *> *)indexPaths previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths movementCancelled:(BOOL)movementCancelled {
//    UICollectionViewLayoutInvalidationContext* context = [super invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:indexPaths previousIndexPaths:previousIndexPaths movementCancelled:movementCancelled];
////    [self.collectionView insertItemsAtIndexPaths:indexPaths];
//
//    return context;
//}


/*
 *  获取当前collectionView的高度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param maxRowCount              允许的最大行数
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param equalCellSizeSetting     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForAllCellCount:(NSInteger)allCellCount
                     maxRowCount:(NSInteger)maxRowCount
           byCollectionViewWidth:(CGFloat)collectionViewWidth
        withEqualCellSizeSetting:(CJCellHorizontalLayout *)equalCellSizeSetting
{
    CGFloat minimumLineSpacing = equalCellSizeSetting.minimumLineSpacing;
    CGFloat minimumInteritemSpacing = equalCellSizeSetting.minimumInteritemSpacing;
    UIEdgeInsets sectionInset = equalCellSizeSetting.sectionInset;

    //计算cell的宽度
    CGSize collectionViewCellSize = [equalCellSizeSetting sizeForItemWithCollectionViewSize:CGSizeMake(collectionViewWidth, 0)];
    CGFloat collectionViewCellWidth = collectionViewCellSize.width;
    CGFloat collectionViewCellHeight = collectionViewCellSize.height;
    NSInteger perRowMaxShowCount = 0;
    if (equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount) {
        CGFloat validWidth = collectionViewWidth - sectionInset.left - sectionInset.right;
        perRowMaxShowCount = (validWidth+minimumInteritemSpacing)/(collectionViewCellWidth+minimumInteritemSpacing);
    } else {
        perRowMaxShowCount = equalCellSizeSetting.cellWidthFromPerRowMaxShowCount;
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
