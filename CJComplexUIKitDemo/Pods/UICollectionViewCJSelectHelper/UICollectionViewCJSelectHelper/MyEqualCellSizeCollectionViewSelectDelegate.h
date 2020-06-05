//
//  MyEqualCellSizeCollectionViewSelectDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJCollectionViewLayout/CQCollectionViewFlowLayout.h>

typedef NS_ENUM(NSUInteger, DataCellActionType) {
    DataCellActionTypeNone = 0,     /**< 不操作 */
    DataCellActionTypeBrowse,       /**< 浏览 */
    DataCellActionTypeSelect,       /**< 勾选选中/取消选中 */
};


/**
 *  一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)(采用常用的init...方法后，即可初始化完成)
     这里的collectionLayout，只能为flow
 */
@interface MyEqualCellSizeCollectionViewSelectDelegate : NSObject <UICollectionViewDelegateFlowLayout> {
    
}
@property (nonatomic, strong, readonly) CQCollectionViewFlowLayout *flowLayout; /**< 集合视图的布局设置 */

@property (nonatomic, assign) BOOL isChoosing;  /**< 是否是选择操作，如果否则为只是展示 */

/*
 *  初始化delegate类(处理布局及点击操作)
 *
 *  @param flowLayout           集合视图的布局设置
 *  @param alwaysAloneIndexPath  与其他不共存的indexPath(即如果点击的是这个不共存的indexPath的时候，之前已选中的会被全被设为未选中。如无，则传nil)
 *  @param cellBrowseBlock      非选择(浏览)时候才会调用：
 *  @param cellSelectedBlock    选择时候才会调用：你自己只需要更新当前点击的这个cell(其他cell的更新我已根据各种情形帮你处理完了)
 */
- (id)initWithFlowLayout:(CQCollectionViewFlowLayout *)flowLayout
withAlwaysAloneIndexPath:(NSIndexPath *)alwaysAloneIndexPath
         cellBrowseBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath))cellBrowseBlock
       cellSelectedBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath))cellSelectedBlock;


@end
