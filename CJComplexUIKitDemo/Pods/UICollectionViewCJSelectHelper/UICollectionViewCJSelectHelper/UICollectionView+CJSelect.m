//
//  UICollectionView+CJSelect.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/15.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UICollectionView+CJSelect.h"

@implementation UICollectionView (CJSelect)

/*
*  选中indexPath(已支持单选、多选模式)
*
*  @param indexPath             当前选中的indexPath
*  @param alwaysAloneIndexPath  与其他不共存的indexPath(即如果点击的是这个不共存的indexPath的时候，之前已选中的会被全被设为未选中。如无，则传nil)
*  @param thisCellUpdateBlock   你自己只需要更新当前点击的这个cell(其他cell的更新我已根据各种情形帮你处理完了)
*/
- (void)my_didTapItemAtIndexPath:(NSIndexPath *)indexPath
        withAlwaysAloneIndexPath:(NSIndexPath *)alwaysAloneIndexPath
             thisCellUpdateBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath))thisCellUpdateBlock
{
    /* 测试“我与其他不共存功能” */
    if ([indexPath isEqual:alwaysAloneIndexPath]) {
        [self my_deselectOtherExceptIndexPath:indexPath];
        
    } else {
        if ([self.indexPathsForSelectedItems containsObject:alwaysAloneIndexPath]) {//选择其他cell时候，如果独立的cell是选中的，则应去除独立cell的选中状态
            [self reloadItemsAtIndexPaths:@[alwaysAloneIndexPath]];
        }
        
        //对当前的cell进行改变，不要为了更新一个cell的状态，而去调用reload方法，那样消耗太大，即
        //方法①：可取且最优的方法如下
        //UICollectionViewCell *dataCell = [self cellForItemAtIndexPath:indexPath];
        if (thisCellUpdateBlock) {
            thisCellUpdateBlock(self, indexPath);
        }
        //方法②：可用有效，但不可取的方法如下
        //[self reloadDataWithKeepSelectedState:YES];
    }
}

#pragma mark - reload
/* 完整的描述请参见文件头部 */
- (void)my_reloadDataWithKeepSelectedState:(BOOL)keep {
    if (keep == NO) {
        [self reloadData];
        
    } else {
        //是否要保持原来的选中状态，如果是的话，请在刷新前，记录下之前的有哪些IndexPath被选中
        NSArray *oldIndexPathsForSelectedItems = [self indexPathsForSelectedItems];
        //NSLog(@"oldIndexPathsForSelectedItems = %@", oldIndexPathsForSelectedItems);
        
        [self reloadData];
        for (NSIndexPath *indexPath in oldIndexPathsForSelectedItems) {
            [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
}

#pragma mark - select & deselect & invertselect
/* 完整的描述请参见文件头部 */
- (void)my_selectAllAndReloadData {
    [self reloadData];
    
    NSInteger cellCount = [self numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

/* 完整的描述请参见文件头部 */
- (void)my_invertselectIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self reloadData];
    
    NSInteger cellCount = [self numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        if ([indexPaths containsObject:indexPath]) {    //反选
            [self deselectItemAtIndexPath:indexPath animated:NO];
        } else {
            [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
}


/* 完整的描述请参见文件头部 */
- (void)my_deselectOtherExceptIndexPath:(NSIndexPath *)indexPath {
    [self reloadData];
    
    [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}


@end
