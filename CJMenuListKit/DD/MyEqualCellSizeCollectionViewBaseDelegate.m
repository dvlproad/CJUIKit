//
//  MyEqualCellSizeCollectionViewBaseDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeCollectionViewBaseDelegate.h"

@interface MyEqualCellSizeCollectionViewBaseDelegate () {
    
}

@end



@implementation MyEqualCellSizeCollectionViewBaseDelegate


////*
//#pragma mark - UICollectionViewDelegateFlowLayout
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
//                        layout:(UICollectionViewLayout *)collectionViewLayout
//        insetForSectionAtIndex:(NSInteger)section
//{
////    return UIEdgeInsetsMake(10, 10, 10, 10);
//    UIEdgeInsets sectionInset = self.equalCellSizeSetting.sectionInset;
//    return sectionInset;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView
//                   layout:(UICollectionViewLayout *)collectionViewLayout
//minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
////    return 15;
//    CGFloat minimumLineSpacing = self.equalCellSizeSetting.minimumLineSpacing;
//    return minimumLineSpacing;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView
//                   layout:(UICollectionViewLayout *)collectionViewLayout
//minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
////    return 10;
//    CGFloat minimumInteritemSpacing = self.equalCellSizeSetting.minimumInteritemSpacing;
//    return minimumInteritemSpacing;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout*)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGSize collectionViewCellSize = [self.equalCellSizeSetting sizeForItemWithCollectionViewSize:collectionView.frame.size];
//    return collectionViewCellSize;
//    
//    /*
//    CGFloat collectionViewCellWidth = 0;
//    if (equalCellSizeSetting.cellWidthFromFixedWidth > 0) {
//        collectionViewCellWidth = equalCellSizeSetting.cellWidthFromFixedWidth;
//        
//    } else if (equalCellSizeSetting.cellWidthFromPerRowMaxShowCount > 0) {
//        NSInteger cellWidthFromPerRowMaxShowCount = equalCellSizeSetting.cellWidthFromPerRowMaxShowCount;
//        
//        UIEdgeInsets sectionInset = [self collectionView:collectionView
//                                                  layout:collectionViewLayout
//                                  insetForSectionAtIndex:indexPath.section];
//        CGFloat minimumInteritemSpacing = [self collectionView:collectionView
//                                                        layout:collectionViewLayout
//                      minimumInteritemSpacingForSectionAtIndex:indexPath.section];
//        
//        CGFloat width = CGRectGetWidth(collectionView.frame);
//        CGFloat validWith = width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*(cellWidthFromPerRowMaxShowCount-1);
//        collectionViewCellWidth = floorf(validWith/cellWidthFromPerRowMaxShowCount);
//    }
//    
//    CGFloat collectionViewCellHeight = 0;
//    if (equalCellSizeSetting.cellHeightFromFixedHeight >0) {
//        collectionViewCellHeight = equalCellSizeSetting.cellHeightFromFixedHeight;
//    } else if (equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount > 0) {
//        NSInteger cellHeightFromPerColumnMaxShowCount = equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount;
//        
//        UIEdgeInsets sectionInset = [self collectionView:collectionView
//                                                  layout:collectionViewLayout
//                                  insetForSectionAtIndex:indexPath.section];
//        CGFloat minimumLineSpacing = [self collectionView:collectionView
//                                                   layout:collectionViewLayout
//                      minimumLineSpacingForSectionAtIndex:indexPath.section];
//        
//        CGFloat height = CGRectGetHeight(collectionView.frame);
//        CGFloat validHeight = height - sectionInset.top - sectionInset.bottom - minimumLineSpacing*(cellHeightFromPerColumnMaxShowCount-1);
//        collectionViewCellHeight = floorf(validHeight/cellHeightFromPerColumnMaxShowCount);
//    }
//    
//    
//    NSAssert(collectionViewCellWidth > 0 || collectionViewCellHeight > 0, @"collectionViewCell 的 width 与 height 不能都未设置");
//    if (collectionViewCellWidth > 0 && collectionViewCellHeight > 0) {
//        NSLog(@"collectionViewCell 的 width 与 height 已设置完毕");
//        return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
//    }
//    
//    NSAssert(equalCellSizeSetting.widthHeightRatio > 0, @"在只设置宽或高时，需要由比例来计算另一个值，所以比例值必须大于0");
//    if (collectionViewCellWidth > 0) {
//        collectionViewCellHeight = collectionViewCellWidth/equalCellSizeSetting.widthHeightRatio;
//    } else {
//        collectionViewCellWidth = collectionViewCellHeight*equalCellSizeSetting.widthHeightRatio;
//    }
//    
//    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
//    */
//}
////*/

#pragma mark - UICollectionViewDelegate
// 此点击部分请在子类中实现
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"此点击部分请在子类中实现");
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"此点击部分请在子类中实现");
}

@end
