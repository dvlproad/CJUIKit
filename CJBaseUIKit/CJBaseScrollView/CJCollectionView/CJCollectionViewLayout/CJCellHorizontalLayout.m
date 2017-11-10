//
//  CJCellHorizontalLayout.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16-5-30.
//  Copyright (c) 2016年 dvlproad. All rights reserved.
//

#import "CJCellHorizontalLayout.h"


static CGFloat itemSpacing = 10;
static CGFloat lineSpacing = 10;



@interface CJCellHorizontalLayout() {
    
}
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSMutableArray *leftArray;
@property (nonatomic, strong) NSMutableDictionary *heigthDic;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;
@property (nonatomic, strong) NSMutableArray *indexPathsToAnimate;

@end



@implementation CJCellHorizontalLayout
{
    int _row;
    int _line;
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
    
    
//    self.itemSize = CGSizeMake(70, 85);
//    self.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
//    self.minimumLineSpacing = 1;
//    self.minimumInteritemSpacing = 1;
    
    
    CGFloat itemWidth = self.itemSize.width;
    CGFloat itemHeight = self.itemSize.height;
    
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat height = self.collectionView.frame.size.height;
    
    CGFloat contentWidth = (width - self.sectionInset.left - self.sectionInset.right);
    if (contentWidth >= (2*itemWidth+self.minimumInteritemSpacing)) { //如果列数大于2行
        int m = (contentWidth-itemWidth)/(itemWidth+self.minimumInteritemSpacing);
        _line = m+1;
        int n = (int)(contentWidth-itemWidth)%(int)(itemWidth+self.minimumInteritemSpacing);
        if (n > 0) {
            double offset = ((contentWidth-itemWidth) - m*(itemWidth+self.minimumInteritemSpacing))/m;
            itemSpacing = self.minimumInteritemSpacing + offset;
        }else if (n == 0){
            itemSpacing = self.minimumInteritemSpacing;
        }
    }else{ //如果列数为一行
        itemSpacing = 0;
    }
    
    CGFloat contentHeight = (height - self.sectionInset.top - self.sectionInset.bottom);
    if (contentHeight >= (2*itemHeight+self.minimumLineSpacing)) { //如果行数大于2行
        int m = (contentHeight-itemHeight)/(itemHeight+self.minimumLineSpacing);
        _row = m+1;
        int n = (int)(contentHeight-itemHeight)%(int)(itemHeight+self.minimumLineSpacing);
        if (n > 0) {
            double offset = ((contentHeight-itemHeight) - m*(itemHeight+self.minimumLineSpacing))/m;
            lineSpacing = self.minimumLineSpacing + offset;
        }else if (n == 0){
            lineSpacing = self.minimumInteritemSpacing;
        }
    }else{ //如果行数数为一行
        lineSpacing = 0;
    }


    int itemNumber = 0;

    itemNumber = itemNumber + (int)[self.collectionView numberOfItemsInSection:0];

    pageNumber = (itemNumber - 1)/(_row*_line) + 1;
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
    

    CGRect frame;
    frame.size = self.itemSize;
    //下面计算每个cell的frame   可以自己定义
    long number = _row * _line;
//    printf("%ld\n",number);
    long m = 0;  //初始化 m p
    long p = 0;
    if (indexPath.item >= number) {
//        NSLog(@"indexpath.item:%ld",indexPath.item);
        p = indexPath.item/number;  //计算页数不同时的左间距
//        if ((p+1) > pageNumber) { //计算显示的页数
//            pageNumber = p+1;
//            
//        }
//        NSLog(@"%ld",p);
        m = (indexPath.item%number)/_line;
    }else{
        m = indexPath.item/_line;
    }
    
    long n = indexPath.item%_line;
    frame.origin = CGPointMake(n*self.itemSize.width+(n)*itemSpacing+self.sectionInset.left+(indexPath.section+p)*self.collectionView.frame.size.width,m*self.itemSize.height + (m)*lineSpacing+self.sectionInset.top);
    
//    printf("%d(%f,%f)\n",indexPath.item,frame.origin.x,frame.origin.y);
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

@end
