//
//  MyEqualCellSizeCollectionView+Select.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/9/15.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionView+Select.h"

@implementation MyEqualCellSizeCollectionView (Select)

#pragma mark - reload
/* 完整的描述请参见文件头部 */
- (void)my_reloadDataWithKeepSelectedState:(BOOL)keep {
    if (keep == NO) {
        [super reloadData];
        
    } else {
        //是否要保持原来的选中状态，如果是的话，请在刷新前，记录下之前的有哪些IndexPath被选中
        NSArray *oldIndexPathsForSelectedItems = [self indexPathsForSelectedItems];
        //NSLog(@"oldIndexPathsForSelectedItems = %@", oldIndexPathsForSelectedItems);
        
        [super reloadData];
        for (NSIndexPath *indexPath in oldIndexPathsForSelectedItems) {
            [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
}

#pragma mark - select & deselect & invertselect
/* 完整的描述请参见文件头部 */
- (void)my_selectAllAndReloadData {
    [super reloadData];
    
    NSInteger cellCount = [self numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

/* 完整的描述请参见文件头部 */
- (void)my_invertselectIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [super reloadData];
    
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
    [super reloadData];
    
    [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}


@end
