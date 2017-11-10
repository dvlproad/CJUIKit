//
//  MyEqualCellSizeCollectionView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEqualCellSizeSetting.h"

typedef void (^CJDidTapCollectionViewItemBlock)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect); /**< 包括 didSelectItemAtIndexPath 和didDeselectItemAtIndexPath */


/**
 *  一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)(采用常用的init...方法后，即可初始化完成)
 */
@interface MyEqualCellSizeCollectionView : UICollectionView {
    
}
//必须设置的值
@property (nonatomic, strong) MyEqualCellSizeSetting *equalCellSizeSetting; /**< 集合视图的设置 */
//@property (nonatomic, strong) NSArray<NSIndexPath *> *currentSelectedIndexPaths;    /**< 当前已选中的所有indexPaths（直接通过系统的indexPathsForSelectedItems获得） */

//可选设置的值，不设置采用默认
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;  /**< 设置滚动方向(默认水平滚动) */

///可选：点击Item要执行的方法
@property (nonatomic, copy) CJDidTapCollectionViewItemBlock didTapItemBlock;

- (void)commonInit;


/**
 *  获取当前collectionView的高度
 *
 *  @param dataModels               要传入的collectionView的数据源
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param equalCellSizeSetting     集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForDataModels:(NSArray *)dataModels
         byCollectionViewWidth:(CGFloat)collectionViewWidth
      withEqualCellSizeSetting:(MyEqualCellSizeSetting *)equalCellSizeSetting;


@end
