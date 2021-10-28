//
//  CQTSRipeBaseCollectionView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  为了快速构建完整 Demo 工程提供的成熟的CollectionView(已含内容和事件)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeBaseCollectionView : UICollectionView {
    
}

#pragma mark - Init
/*
 *  初始化 CollectionView
 *
 *  @param sectionRowCounts     每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *  @param perMaxCount          当滚动方向为①水平时,每列显示几个；②竖直时,每行显示几个；
 *  @param scrollDirection      集合视图的滚动方向
 *  @param cellClass                    集合视图的cell类
 *  @param cellForItemAtIndexPathBlock  对指定indexPath的cell进行设置
 *
 *  @return CollectionView
 */
- (instancetype)initWithSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
                             perMaxCount:(NSInteger)perMaxCount
                         scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                               cellClass:(UICollectionViewCell *)cellClass
             cellAtIndexPathConfigBlock:(void(^)(UICollectionViewCell *bCollectionViewCell, NSIndexPath *bIndexPath))cellAtIndexPathConfigBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


@end

NS_ASSUME_NONNULL_END
