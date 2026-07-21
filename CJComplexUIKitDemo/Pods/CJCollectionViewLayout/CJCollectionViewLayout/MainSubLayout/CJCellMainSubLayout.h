//
//  CJCellMainSubLayout.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16-5-30.
//  Copyright (c) 2016年 dvlproad. All rights reserved.
//
//  主副格布局：上主格+下副格

#import <UIKit/UIKit.h>

@interface CJCellMainSubLayout : UICollectionViewFlowLayout {
    
}

/*
 *  初始化
 *
 *  @param mainCellSize             第一个item的大小(初始化layout的时候要用)
 *  @param subCellWidthHeightRatio  其他item的大小(初始化layout的时候要用)
 *
 *  @return layout
 */
- (instancetype)initWithMainCellSize:(CGSize)mainCellSize subCellWidthHeightRatio:(CGFloat)subCellWidthHeightRatio NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

#pragma mark - Other Method Get Height
/*
 *  获取当前collectionView的高度
 *
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForCollectionViewLayout:(CJCellMainSubLayout *)collectionViewLayout;

@end
