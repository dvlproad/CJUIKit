//
//  CQTSRipeImageCollectionView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  为了快速构建完整 Demo 工程提供的成熟的CollectionView(已含内容和事件)，另图片数据源支持全本地图片或全网络图片

#import <UIKit/UIKit.h>
#import "CQTSResourceEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeImageCollectionView : UICollectionView {
    
}
@property (nullable, nonatomic, copy) void(^cellConfigBlock)(UICollectionViewCell *bCell); /**< cell的UI定制（有时候需要cell和其所在列表的背景色为透明） */

#pragma mark - Init
/*
 *  初始化 CollectionView
 *
 *  @param scrollDirection      集合视图的滚动方向
 *  @param perMaxCount          当滚动方向为①水平时,每列显示几个；②竖直时,每行显示几个；
 *  @param widthHeightRatio     宽高比（一般为1.0）
 *
 *  @return CollectionView
 */
- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection
                            perMaxCount:(NSInteger)perMaxCount
                       widthHeightRatio:(CGFloat)widthHeightRatio;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

#pragma mark - Setup
/*
 *  只设置数据源
 *
 *  @param sectionRowCounts     每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *  @param ripeImageSource      数据源(有网络图片、本地图片、网络icon)
 */
- (void)setupSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
              ripeImageSource:(CQTSRipeImageSource)ripeImageSource;

/* 初始化示例
CQTSRipeImageCollectionView *collectionView = [[CQTSRipeImageCollectionView alloc] initWithScrollDirection:UICollectionViewScrollDirectionVertical perMaxCount:3 widthHeightRatio:1.0];
[collectionView setupSectionRowCounts:@[@1, @3, @6, @8] ripeImageSource:CQTSRipeImageSourceImageNetwork];
collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
collectionView.cellConfigBlock = ^(UICollectionViewCell * _Nonnull bCell) {
    bCell.contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    bCell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
};
[self.view addSubview:collectionView];
[collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.mas_equalTo(self.view);
    make.height.mas_equalTo(200);
}];
*/

@end

NS_ASSUME_NONNULL_END
