//
//  CQTSRipeButtonCollectionView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  为了提供给某些例子需要有多种情况的测试时候，而快速构建的【单排或单列的按钮组合CollectionView】

#import <UIKit/UIKit.h>
#import "CQTSRipeBaseCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeButtonCollectionView : CQTSRipeBaseCollectionView {
    
}
@property (nullable, nonatomic, copy) void(^cellConfigBlock)(UICollectionViewCell *bCell); /**< cell的UI定制（有时候需要cell和其所在列表的背景色为透明） */

#pragma mark - Init
/*
 *  初始化 单行或单列的CollectionView
 *
 *  @param buttonTitles                 按钮的标题数组
 *  @param scrollDirection              集合视图的滚动方向
 *  @param didSelectItemAtIndexHandle   点击item的回调
 *
 *  @return CollectionView
 */
- (instancetype)initWithTitles:(NSArray<NSString *> *)buttonTitles
               scrollDirection:(UICollectionViewScrollDirection)scrollDirection
    didSelectItemAtIndexHandle:(void(^)(NSInteger index))didSelectItemAtIndexHandle NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
                             perMaxCount:(NSInteger)perMaxCount
                         scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                               cellClass:(UICollectionViewCell *)cellClass
             cellAtIndexPathConfigBlock:(void(^)(UICollectionViewCell *bCollectionViewCell, NSIndexPath *bIndexPath))cellAtIndexPathConfigBlock NS_UNAVAILABLE;

/* 初始化示例
CQTSRipeButtonCollectionView *collectionView = [[CQTSRipeButtonCollectionView alloc] initWithVerticalSectionRowCounts:@[@1, @3, @6, @8] perRowMaxColumnCount:3];
//CQTSRipeButtonCollectionView *collectionView = [[CQTSRipeButtonCollectionView alloc] initWithHorizontalSectionRowCounts:@[@1, @3, @6, @8] perColumnMaxRowCount:3];
collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
collectionView.cellConfigBlock = ^(UICollectionViewCell * _Nonnull bCell) {
    bCell.contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    bCell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
};
*/

@end

NS_ASSUME_NONNULL_END
