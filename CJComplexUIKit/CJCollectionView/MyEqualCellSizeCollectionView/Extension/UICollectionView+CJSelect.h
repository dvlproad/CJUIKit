//
//  UICollectionView+CJSelect.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/15.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (CJSelect)

/*
*  选中indexPath(已支持单选、多选模式)
*
*  @param indexPath             当前选中的indexPath
*  @param alwaysAloneIndexPath  与其他不共存的indexPath(即如果点击的是这个不共存的indexPath的时候，之前已选中的会被全被设为未选中。如无，则传nil)
*  @param thisCellUpdateBlock   你自己只需要更新当前点击的这个cell(其他cell的更新我已根据各种情形帮你处理完了)
*/
- (void)my_didTapItemAtIndexPath:(NSIndexPath *)indexPath
        withAlwaysAloneIndexPath:(NSIndexPath *)alwaysAloneIndexPath
             thisCellUpdateBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath))thisCellUpdateBlock;

#pragma mark - reload
/**
 *  reloadData并同时保持reload前那些已选择的cell的选中状态
 *
 *  @param keep     是否要保存已选中cell的选中状态
 */
- (void)my_reloadDataWithKeepSelectedState:(BOOL)keep;


#pragma mark - select & deselect & invertselect
/**
 *  全选(选择所有的cell)后，并更新视图
 */
- (void)my_selectAllAndReloadData;

/**
 *  对indexPaths外的进行反选
 *
 *  @param indexPaths   对哪些indexPaths外的进行反选
 */
- (void)my_invertselectIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 *  取消除指定indexPath外的所有位置的选中状态
 *  @attention  ①如果是明确deselectAll的话直接用系统的reloadData，或者这里的参数传nil
 *              ②如果是明确deselect某几个的话用系统的reloadItemsAtIndexPaths:即可。
 *              ③如果是不明确deselect哪些，而只是明确deselect除什么之外的那些才采用这个方法
 *
 *  @param indexPath 指定的不更改选中状态的位置
 */
- (void)my_deselectOtherExceptIndexPath:(NSIndexPath *)indexPath;

@end
