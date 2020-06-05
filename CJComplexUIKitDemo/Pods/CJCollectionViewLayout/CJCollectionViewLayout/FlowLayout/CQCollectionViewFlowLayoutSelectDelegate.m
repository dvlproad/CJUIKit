//
//  CQCollectionViewFlowLayoutSelectDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQCollectionViewFlowLayoutSelectDelegate.h"
#import <UICollectionViewCJSelectHelper/UICollectionView+CJSelect.h>

@interface CQCollectionViewFlowLayoutSelectDelegate () {
    
}
@property (nonatomic, copy) void(^cellBrowseBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);
@property (nonatomic, copy) void(^cellSelectedBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);
@property (nonatomic, strong, readonly) NSIndexPath *alwaysAloneIndexPath;/**< 与其他不共存的indexPath(即如果点击的是这个不共存的indexPath的时候，之前已选中的会被全被设为未选中。如无，则传nil) */

@end



@implementation CQCollectionViewFlowLayoutSelectDelegate

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
       cellSelectedBlock:(void(^)(UICollectionView *collectionView, NSIndexPath *indexPath))cellSelectedBlock
{
    self = [super init];
    if (self) {
        _flowLayout = flowLayout;
        _alwaysAloneIndexPath = alwaysAloneIndexPath;
        _cellBrowseBlock = cellSelectedBlock;
        _cellSelectedBlock = cellSelectedBlock;
    }
    return self;
}


//#pragma mark - UICollectionViewDelegateFlowLayout
//略

//#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isChoosing) {
        //NSLog(@"选中");
        [collectionView my_didTapItemAtIndexPath:indexPath
                        withAlwaysAloneIndexPath:self.alwaysAloneIndexPath
                             thisCellUpdateBlock:self.cellSelectedBlock];
    } else {
        //NSLog(@"浏览");
        if (self.cellBrowseBlock) {
            self.cellBrowseBlock(collectionView, indexPath);
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indexPathString = [NSString stringWithFormat:@"%zd-%zd", indexPath.section, indexPath.item];
    NSLog(@"取消点击%", indexPathString);
}



@end
