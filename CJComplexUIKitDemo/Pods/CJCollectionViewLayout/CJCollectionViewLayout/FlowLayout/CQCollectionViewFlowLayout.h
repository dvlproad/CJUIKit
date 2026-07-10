//
//  CQCollectionViewFlowLayout.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  一个可根据[横向或纵向的个数]等方法来均分cell的layout

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQCollectionViewFlowLayout : UICollectionViewFlowLayout {
    
}

//以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
@property (nonatomic, assign) CGFloat cellWidthFromFixedWidth;   /**< 通过cell的固定宽度来设置每个cell的宽度 */
@property (nonatomic, assign) NSUInteger cellWidthFromPerRowMaxShowCount; /**< 通过每行可显示的最多列数来设置每个cell的宽度*/

//以下值可选设置，（默认cellHeightFromFixedHeight设置后，另外一个自动失效，如果两个都没设置，则高等于宽）
@property (nonatomic, assign) CGFloat cellHeightFromFixedHeight; /**< cell高,没设置的话等于其宽 */
@property (nonatomic, assign) NSUInteger cellHeightFromPerColumnMaxShowCount; /**< 通过每列可显示的最多行数来设置每个cell的高度(循环的时候可设这个值为1即可) */

@property (nonatomic, assign) CGFloat widthHeightRatio; /**< 宽高比（默认1:1,即1/1.0，请确保除数有小数点，否则1/2会变成0，而不是0.5） */



#pragma mark - Other Method Get Height
/*
 *  获取当前collectionView的高度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param maxRowCount              允许的最大行数(即超过的部分需要滚动，若要计算全部高展开的高度，则此值用NSIntegerMax)
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForAllCellCount:(NSInteger)allCellCount
                     maxRowCount:(NSInteger)maxRowCount
           byCollectionViewWidth:(CGFloat)collectionViewWidth
        withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout;
/*
 *  获取当前collectionView的高度
 *
 *  @param currentRowCount          指定的行数
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForRowCount:(NSInteger)currentRowCount
       byCollectionViewWidth:(CGFloat)collectionViewWidth
    withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout;


/*
 *  获取collectionViewWidth按collectionViewLayout布局时候，每行最大显示的item个数/列数
 *
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param collectionViewCellWidth  cell的宽度(此值由collectionViewWidth计算得来)
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 每行最大显示的item个数
 */
+ (NSInteger)maxColumnCountInCollectionViewWidth:(CGFloat)collectionViewWidth
                         collectionViewCellWidth:(CGFloat)collectionViewCellWidth
                        withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout;





#pragma mark - Other Method Get Width
/*
 *  获取当前collectionView的宽度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param maxColumnCount           允许的最大列数(即超过的部分需要滚动，若要计算全部高展开的宽度，则此值用NSIntegerMax)
 *  @param collectionViewHeight     要传入的collectionView的高度
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)widthForAllCellCount:(NSInteger)allCellCount
                 maxColumnCount:(NSInteger)maxColumnCount
         byCollectionViewHeight:(CGFloat)collectionViewHeight
       withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout;
/*
 *  获取当前collectionView的宽度
 *
 *  @param currentColumnCount       指定的列数
 *  @param collectionViewHeight     要传入的collectionView的高度
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)widthForColumnCount:(NSInteger)currentColumnCount
        byCollectionViewHeight:(CGFloat)collectionViewHeight
      withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout;


/*
 *  获取collectionViewHeight按collectionViewLayout布局时候，每列最大显示的item个数
 *
 *  @param collectionViewHeight     要传入的collectionView的高度
 *  @param collectionViewCellHeight cell的高度(此值由collectionViewHeight计算得来)
 *  @param collectionViewLayout     集合视图的布局
 *
 *  @return 每列最大显示的item个数
 */
+ (NSInteger)maxRowCountInCollectionViewHeight:(CGFloat)collectionViewHeight
                      collectionViewCellHeight:(CGFloat)collectionViewCellHeight
                      withCollectionViewLayout:(CQCollectionViewFlowLayout *)collectionViewLayout;

@end

NS_ASSUME_NONNULL_END
