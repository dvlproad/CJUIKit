//
//  CQTSRipeBaseCollectionViewEasyDataSource.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQDMSectionDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeBaseCollectionViewEasyDataSource : NSObject<UICollectionViewDataSource>

#pragma mark - Init
/*
 *  初始化 CollectionView 的 dataSource
 *
 *  @param sectionRowCounts             每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *  @param cellForItemAtIndexPathBlock  对指定indexPath的cell进行设置
 *
 *  @return CollectionView 的 dataSource
 */
- (instancetype)initWithSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts
              cellAtIndexPathConfigBlock:(void(^)(UICollectionViewCell *bCollectionViewCell, NSIndexPath *bIndexPath))cellAtIndexPathConfigBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)registerAllCellsForCollectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
