//
//  CJCellMainSubLayout.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/10/8.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJCellMainSubLayout.h"

@interface CJCellMainSubLayout () {
    NSMutableDictionary *dic_attributes_cell; // 记录所有cell布局属性的字典
    NSMutableDictionary *dic_attributes_header; // 记录所有head布局属性的字典
}
@property (nonatomic, assign, readonly) CGRect lastHorizontalFrame;     // 上一个水平item的布局
@property (nonatomic, assign, readonly) CGRect firstFrame;              // 第一个item的布局

@end

@implementation CJCellMainSubLayout

- (NSIndexPath *)indexPathFromString:(NSString *)indexPathString {
    NSArray *array = [indexPathString componentsSeparatedByString:@"-"];
    NSInteger section = [array[0] integerValue];
    NSInteger item = [array[1] integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
    return indexPath;
}

- (NSString *)indexPathStringFromIndexPath:(NSIndexPath *)indexPath {
    NSString *indexPathString = [NSString stringWithFormat:@"%zd-%zd",indexPath.section, indexPath.item];
    return indexPathString;
}


- (void)prepareLayout {  //这个方法是每次要布局时都会调用，你可以在这里面设置默认参数
    [super prepareLayout];
    
    dic_attributes_cell = [[NSMutableDictionary alloc]init];
    dic_attributes_header = [[NSMutableDictionary alloc]init];
    [self prepareAllLayoutAttributes];
    //[self registerClass:[CVDEView class] forDecorationViewOfKind:@"CVDEView"];
}


/**
 *  初始化所有布局
 *
 *  @return 初始化的所有布局
 */
- (NSMutableArray *)prepareAllLayoutAttributes {
    NSMutableArray *m_attributes = [NSMutableArray array];
    
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    CGFloat collectionViewHeight = CGRectGetHeight(self.collectionView.frame);
    CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
    CGFloat itemWidth = self.itemSize.width;
    CGFloat itemHeight = self.itemSize.height;
    UIEdgeInsets sectionInset = self.sectionInset;
    CGFloat headerWidth = self.headerReferenceSize.width;
    CGFloat headerHeight = self.headerReferenceSize.height;
    
    NSInteger sections = [self.collectionView numberOfSections];
    
    
    for (NSInteger section = 0 ; section < sections; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            //[m_attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
            
            UICollectionViewLayoutAttributes *cellAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
        
            CGFloat mainCellWidth = 200;
            CGFloat mainCellHeight = 200;
            CGFloat lastCellWidth = collectionViewWidth - self.sectionInset.left - mainCellWidth - self.minimumInteritemSpacing - self.sectionInset.right;
            CGFloat lastCellHeight = collectionViewHeight - self.sectionInset.top - mainCellHeight - self.minimumLineSpacing - self.sectionInset.bottom;
            
            // 计算水平和竖直cell的大小
            NSInteger horizontalSubCellCount = itemCount-1; // 水平方向上subCell的个数(不包括最右下角那个cell)
            CGFloat allValidHorizontalCellWidth = mainCellWidth-(horizontalSubCellCount-1)*self.minimumInteritemSpacing;
            CGFloat subHorizontalCellWidth = allValidHorizontalCellWidth/horizontalSubCellCount;
            
            // 计算水平和竖直cell的frame
            CGFloat itemOriginY = 0;
            CGFloat itemOriginX = 0; // 会根据每个item进行更新
            CGFloat subCellWidth = 0;
            CGFloat subCellHeight = 0;
            
            CGRect cellFrame;
            if (item == 0) {
                itemOriginX = collectionViewWidth/2-mainCellWidth/2;
                itemOriginY = sectionInset.top;
                cellFrame = CGRectMake(itemOriginX, itemOriginY, mainCellWidth, mainCellHeight);
                
                // 更新上一个item的位置
                _firstFrame = cellFrame;
                
            } else { // 水平方向上除最右下角cell外的cell布局
                itemOriginY = CGRectGetMaxY(self.firstFrame) + self.minimumLineSpacing;
                if (item == 1) {
                    itemOriginX = CGRectGetMinX(self.firstFrame);
                } else {
                    itemOriginX = CGRectGetMaxX(self.lastHorizontalFrame) + self.minimumInteritemSpacing;
                }
                subCellHeight = collectionViewHeight - itemOriginY - self.sectionInset.bottom;
                subCellWidth = subHorizontalCellWidth;
                cellFrame = CGRectMake(itemOriginX, itemOriginY, subCellWidth, subCellHeight);
                
                // 更新上一个item的位置
                _lastHorizontalFrame = cellFrame;
            }
            //NSLog(@"cellFrame = %@", NSStringFromCGRect(cellFrame));
            
            cellAttributes.frame = cellFrame;
            [m_attributes addObject:cellAttributes];
            
            NSString *indexPathString = [NSString stringWithFormat:@"%zd-%zd",indexPath.section, indexPath.item];
            [dic_attributes_cell setValue:NSStringFromCGRect(cellAttributes.frame) forKey:indexPathString];
        }
    }
    return m_attributes;
}




- (CGSize)collectionViewContentSize{
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    CGFloat collectionViewHeight = CGRectGetHeight(self.collectionView.frame);
    return CGSizeMake(collectionViewWidth, collectionViewHeight);
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    //return [self prepareAllLayoutAttributes]; //shouldn't recalculate all
    
    NSMutableArray *layoutAttributes = [NSMutableArray arrayWithCapacity:0];
    /** Cell */
    NSArray *visibleIndexPathsOfItems = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPathsOfItems) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    /** Supplementary views */
    NSArray *visibleIndexPathsOfHeader = [self indexPathsOfHeaderViewsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPathsOfHeader) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    return layoutAttributes;
}


/**
 *  获取指定rect区域中所有item的indexPath
 *
 *  @param rect The rect requesting this information.
 *
 *  @return An array of NSIndexPath objects, each of which corresponds to a single item in rect.
 */
- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect {
    NSMutableArray *visibleIndexPathsOfItems = [NSMutableArray array];
    for (NSString *indexPathString in dic_attributes_cell.allKeys) {
        NSString *rectString = [dic_attributes_cell valueForKey:indexPathString];
        CGRect cellRect = CGRectFromString(rectString);
        if (CGRectIntersectsRect(cellRect, rect)) {
            NSIndexPath *indexPath = [self indexPathFromString:indexPathString];
            [visibleIndexPathsOfItems addObject:indexPath];
        }
    }
    return visibleIndexPathsOfItems;
}

/**
 *  获取指定rect区域中所有header的indexPath
 *
 *  @param rect The rect requesting this information.
 *
 *  @return An array of NSIndexPath objects, each of which corresponds to a single header in rect.
 */
- (NSArray *)indexPathsOfHeaderViewsInRect:(CGRect)rect {
    NSMutableArray *visibleIndexPathsOfHeader = [NSMutableArray array];
    for (NSString *indexPathString in dic_attributes_header.allKeys) {
        NSString *rectString = [dic_attributes_header valueForKey:indexPathString];
        CGRect cellRect = CGRectFromString(rectString);
        if (CGRectIntersectsRect(cellRect, rect)) {
            NSIndexPath *indexPath = [self indexPathFromString:indexPathString];
            [visibleIndexPathsOfHeader addObject:indexPath];
        }
    }
    return visibleIndexPathsOfHeader;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSString *frame = [dic_attributes_cell valueForKey:[self indexPathStringFromIndexPath:indexPath]];
    attributes.frame = CGRectFromString(frame);
    return attributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString *frame = [dic_attributes_header valueForKey:[self indexPathStringFromIndexPath:indexPath]];
        attributes.frame = CGRectFromString(frame);
    }
    return attributes;
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    //NSLog(@"BoundsChange");
    return !CGRectEqualToRect(self.collectionView.bounds, newBounds);
}

@end
