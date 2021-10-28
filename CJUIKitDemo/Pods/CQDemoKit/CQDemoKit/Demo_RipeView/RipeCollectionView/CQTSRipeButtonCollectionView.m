//
//  CQTSRipeButtonCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSRipeButtonCollectionView.h"
#import "CQTSRipeButtonCollectionViewCell.h"

@interface CQTSRipeButtonCollectionView () {
    
}
@property (nonatomic, strong) NSMutableArray<NSString *> *buttonTitles;
@property (nullable, nonatomic, copy, readonly) void(^didSelectItemAtIndexHandle)(NSInteger index); /**< 点击item的回调 */

@end


@implementation CQTSRipeButtonCollectionView

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
    didSelectItemAtIndexHandle:(void(^)(NSInteger index))didSelectItemAtIndexHandle
{
    NSNumber *number = [NSNumber numberWithInteger:buttonTitles.count];
    NSArray<NSNumber *> *sectionRowCounts = @[number];
    NSInteger perMaxCount = 1;
    
    self = [super initWithSectionRowCounts:sectionRowCounts perMaxCount:perMaxCount scrollDirection:scrollDirection cellClass:[CQTSRipeButtonCollectionViewCell class] cellAtIndexPathConfigBlock:^(UICollectionViewCell * _Nonnull bCollectionViewCell, NSIndexPath * _Nonnull bIndexPath) {
        CQTSRipeButtonCollectionViewCell *cell = (CQTSRipeButtonCollectionViewCell *)bCollectionViewCell;
        
        NSString *title = buttonTitles[bIndexPath.item];
        cell.text = title;
        
        !self.cellConfigBlock ?: self.cellConfigBlock(cell);
    }];
    if (self) {
        _didSelectItemAtIndexHandle = didSelectItemAtIndexHandle;
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.didSelectItemAtIndexHandle ?: self.didSelectItemAtIndexHandle(indexPath.item);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
