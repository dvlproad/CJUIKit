//
//  MyEqualCellSizeCollectionViewNormalDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEqualCellSizeCollectionViewBaseDelegate.h"


/**
 *  一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)(采用常用的init...方法后，即可初始化完成)
     这里的collectionLayout，只能为flow
 */
@interface MyEqualCellSizeCollectionViewNormalDelegate : MyEqualCellSizeCollectionViewBaseDelegate <UICollectionViewDelegateFlowLayout> {
    
}
/**
 *  初始化delegate类
 *
 *  @param equalCellSizeSetting             集合视图的布局设置
 *  @param didTapItemBlock                         包括 didSelectItemAtIndexPath 和didDeselectItemAtIndexPath
 */
- (id)initWithEqualCellSizeSetting:(CQCollectionViewFlowLayout *)equalCellSizeSetting
                   didTapItemBlock:(void (^)(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect, CQCollectionViewFlowLayout *equalCellSizeSetting))didTapItemBlock;


@end
