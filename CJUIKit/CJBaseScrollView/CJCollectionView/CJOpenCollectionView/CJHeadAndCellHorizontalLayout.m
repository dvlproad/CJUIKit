//
//  CJHeadAndCellHorizontalLayout.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 16/10/8.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJHeadAndCellHorizontalLayout.h"

#import "CJOpenCollectionView.h"

@interface CJHeadAndCellHorizontalLayout () {
    NSInteger collectionViewContentSizeWidth; // 记录collectionView内容的宽度
    NSMutableDictionary *dic_attributes_cell; // 记录所有cell布局属性的字典
    NSMutableDictionary *dic_attributes_header; // 记录所有head布局属性的字典
}

@end

@implementation CJHeadAndCellHorizontalLayout

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
    collectionViewContentSizeWidth = 0;
    
    CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
    CGFloat itemWidth = self.itemSize.width;
    CGFloat itemHeight = self.itemSize.height;
    CGFloat collectionViewHeight = CGRectGetHeight(self.collectionView.frame);
    CGFloat sectionInsetLeft = self.sectionInset.left;
    CGFloat sectionInsetRight = self.sectionInset.right;
    CGFloat headerWidth = self.headerReferenceSize.width;
    CGFloat headerHeight = self.headerReferenceSize.height;
    
    CGFloat headerOriginY = collectionViewHeight/2-headerHeight/2;
    
    CGFloat modelHeight = itemHeight + _lineHeight + _distanceItemAndLine;
    CGFloat modelOriginY = collectionViewHeight/2 - modelHeight/2;
    CGFloat modelDetailCellOriginY = modelOriginY;
    CGFloat modelLineCellOriginY = modelOriginY + itemHeight + _distanceItemAndLine;
    
    
    NSInteger sections = [self.collectionView numberOfSections];
    
    
    for (NSInteger section = 0 ; section < sections; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        CGFloat sectionOriginX = collectionViewContentSizeWidth;
        
        CGFloat lineWidth = sectionInsetLeft + (itemCount-1)*itemWidth + (itemCount-2)*minimumInteritemSpacing + sectionInsetRight;
        CGFloat lineHeight = self.lineHeight;
        if (lineHeight == 0) {
            NSLog(@"warning: the collectionView lineHeight == 0");
        }
        
        
        //elementKind
        if (1) {  //TODO是否有头的判断
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
            //UICollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
            //UICollectionViewLayoutAttributes *decorationAttributes = [self layoutAttributesForDecorationViewOfKind:@"CDV" atIndexPath:indexPath];
            
            headerAttributes.frame = CGRectMake(collectionViewContentSizeWidth, headerOriginY, headerWidth, headerHeight);
            [m_attributes addObject:headerAttributes];
            NSString *indexPathString = [NSString stringWithFormat:@"%zd-0",indexPath.section];
            [dic_attributes_header setValue:NSStringFromCGRect(headerAttributes.frame) forKey:indexPathString];
            
            collectionViewContentSizeWidth += headerWidth;
        }
        
        for (NSInteger item = 0; item < itemCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            //[m_attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
            
            UICollectionViewLayoutAttributes *cellAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            if (((CJOpenCollectionView *)self.collectionView).shouldContainLineCell && itemCount > 1 && item == itemCount-1) {
                cellAttributes.frame = CGRectMake(sectionOriginX+headerWidth, modelLineCellOriginY, lineWidth, lineHeight);
            }else{
                if (item == 0) {
                    collectionViewContentSizeWidth += sectionInsetLeft;
                    cellAttributes.frame = CGRectMake(collectionViewContentSizeWidth, modelDetailCellOriginY, itemWidth, itemHeight);
                }else{
                    cellAttributes.frame = CGRectMake(collectionViewContentSizeWidth, modelDetailCellOriginY, itemWidth, itemHeight);
                }
                collectionViewContentSizeWidth += itemWidth + minimumInteritemSpacing;
            }
            [m_attributes addObject:cellAttributes];
            NSString *indexPathString = [NSString stringWithFormat:@"%zd-%zd",indexPath.section, indexPath.item];
            [dic_attributes_cell setValue:NSStringFromCGRect(cellAttributes.frame) forKey:indexPathString];
        }
    }
    return m_attributes;
}




- (CGSize)collectionViewContentSize{
    return CGSizeMake(collectionViewContentSizeWidth, self.collectionView.frame.size.height);
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
