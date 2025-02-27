//
//  CQTSRipeBaseCollectionViewDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  为了快速构建完整 Demo 工程提供的成熟的CollectionView的布局和点击委托

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeBaseCollectionViewDelegate : NSObject<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate> {
    
}

#pragma mark - Init
/*
 *  初始化 CollectionView 的 delegate
 *
 *  @param perMaxCount          当滚动方向为①水平时,每列显示几个；②竖直时,每行显示几个；
 *  @param didSelectItemHandle  点击item时候要处理的事件
 *
 *  @return CollectionView
 */
- (instancetype)initWithPerMaxCount:(NSInteger)perMaxCount
                didSelectItemHandle:(nullable void(^)(UICollectionView *bCollectionView, NSIndexPath *bIndexPath))didSelectItemHandle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/*
 *  注册 CollectionView 所需的所有 cell
 */
- (void)registerAllCellsForCollectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
