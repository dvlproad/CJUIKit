//
//  MyEqualCellSizeCollectionViewBaseDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQCollectionViewFlowLayout.h"

/**
 *  一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)(采用常用的init...方法后，即可初始化完成)
     这里的collectionLayout，只能为flow
 */
@interface MyEqualCellSizeCollectionViewBaseDelegate : NSObject <UICollectionViewDelegateFlowLayout> {
    
}
//必须设置的值
@property (nonatomic, strong) CQCollectionViewFlowLayout *flowLayout; /**< 集合视图的布局设置 */

#pragma mark - Other
/*
 *  获取当前collectionView的高度
 *
 *  @param allCellCount             collectionView中cell(含dataCell和extralCell)的总数
 *  @param collectionViewWidth      要传入的collectionView的宽度
 *  @param flowLayout               集合视图的布局
 *
 *  @return 当前collectionView的高度
 */
+ (CGFloat)heightForAllCellCount:(NSInteger)allCellCount
           byCollectionViewWidth:(CGFloat)collectionViewWidth
        withEqualCellSizeSetting:(CQCollectionViewFlowLayout *)flowLayout;

@end
