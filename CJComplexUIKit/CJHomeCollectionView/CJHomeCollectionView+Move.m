//
//  CJHomeCollectionView+Move.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJHomeCollectionView+Move.h"
#import <objc/runtime.h>
#import <CJBaseUIKit/UIView+CJShake.h>

static NSString * const cjCheckSectionMoveEnableBlockKey = @"cjCheckSectionMoveEnableBlockKey";
static NSString * const cjCheckCellMoveEnableBlockKey = @"cjCheckCellMoveEnableBlockKey";

//static NSString * const cjShakeGestureRecognizerKey = @"cjShakeGestureRecognizerKey";

@interface CJHomeCollectionView () {
    
}
//@property (nonatomic, strong) UILongPressGestureRecognizer *cjShakeGestureRecognizer;   /** 抖动手势   */

@end

@implementation CJHomeCollectionView (Move)

#pragma mark - runtime
////cjShakeGestureRecognizer
//- (UILongPressGestureRecognizer *)cjShakeGestureRecognizer {
//    return objc_getAssociatedObject(self, &cjShakeGestureRecognizerKey);
//}
//
//- (void)setCjShakeGestureRecognizer:(UILongPressGestureRecognizer *)cjShakeGestureRecognizer {
//    objc_setAssociatedObject(self, (__bridge const void *)(cjShakeGestureRecognizerKey), cjShakeGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}


//cjCheckSectionMoveEnableBlock
- (BOOL (^)(NSIndexPath * _Nonnull))cjCheckSectionMoveEnableBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cjCheckSectionMoveEnableBlockKey));
}

- (void)setCjCheckSectionMoveEnableBlock:(BOOL (^)(NSIndexPath * _Nonnull))cjCheckSectionMoveEnableBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cjCheckSectionMoveEnableBlockKey), cjCheckSectionMoveEnableBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//cjCheckCellMoveEnableBlock
- (BOOL (^)(NSInteger fromSection, NSInteger toSection))cjCheckCellMoveEnableBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cjCheckCellMoveEnableBlockKey));
}

- (void)setCjCheckCellMoveEnableBlock:(BOOL (^)(NSInteger fromSection, NSInteger toSection))cjCheckCellMoveEnableBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cjCheckCellMoveEnableBlockKey), cjCheckCellMoveEnableBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  添加手势
 *
 *  @param containShakeGR   是否包含抖动手势
 */
- (void)addGestureRecognizerWithContainShakeGR:(BOOL)containShakeGR {
    if (containShakeGR) {
        UILongPressGestureRecognizer *shakeGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__shakeGRAction:)];
        shakeGR.minimumPressDuration = 0.5;
        [self addGestureRecognizer:shakeGR];
        self.cjShakeGestureRecognizer = shakeGR;
        
    } else {
        [self __addMoveGestureRecognizer];
    }
}


- (void)__shakeGRAction:(UILongPressGestureRecognizer *)shakeLongPressGR {
    switch (shakeLongPressGR.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self __cjShakeBeginToMove];
            break;
        }
        case UIGestureRecognizerStateChanged:
        case UIGestureRecognizerStateEnded:
        default:
        {
            break;
        }
    }
}

/// 添加拖动的手势
- (void)__addMoveGestureRecognizer {
    if (self.cjShakeGestureRecognizer) {
        [self removeGestureRecognizer:self.cjShakeGestureRecognizer];
    }
    UILongPressGestureRecognizer *moveGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__cjMoveGRAction:)];
    moveGR.minimumPressDuration = 1.0;
    if (self.cjShakeType == CJShakeTypeMoving) {
        moveGR.minimumPressDuration = 0.3;
    }
    [self addGestureRecognizer:moveGR];
    self.cjMoveGestureRecognizer = moveGR;
}
 


#pragma mark - UICollectionViewDataSource
//开启collectionView可以移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cjCheckSectionMoveEnableBlock) {
        return self.cjCheckSectionMoveEnableBlock(indexPath);
    }
    
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

//处理collectionView移动过程中的数据操作
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //从数据源中移除该数据
    CJSectionDataModel *sourceSectionDataModel = [self.menuSectionDataModels objectAtIndex:sourceIndexPath.section-self.menuSectionStartIndex];
    id dataModel = [sourceSectionDataModel.values objectAtIndex:sourceIndexPath.item];
    [sourceSectionDataModel.values removeObject:dataModel];
    //并将数据插入到数据源中目标位置
    CJSectionDataModel *destinationSectionDataModel = [self.menuSectionDataModels objectAtIndex:destinationIndexPath.section-self.menuSectionStartIndex];
    [destinationSectionDataModel.values insertObject:dataModel atIndex:destinationIndexPath.row];
    NSLog(@"移动完毕");
}




#pragma mark - Private Method
/// 开始抖动，以进行拖动
- (void)__cjShakeBeginToMove {
    self.cjShakeType = CJShakeTypeMoving;
    [self reloadData];
    
    [self __addMoveGestureRecognizer];
}

/// 拖动结束
- (void)__cjMoveEnd {
    if (self.cjShakeType == CJShakeTypeMoving) {
        // 如果之前是有抖动的，则设置抖动结束，如果不是，则其值仍为原来的CJShakeTypeNever
        self.cjShakeType == CJShakeTypeEnd;
        [self addGestureRecognizerWithContainShakeGR:YES];
    }
    
    [self reloadData];
}

/// 拖动过程中的监听
- (void)__cjMoveGRAction:(UILongPressGestureRecognizer *)moveLongPressGR {
    static NSInteger fromSection = 0;    // 记录section，防止跨section移动
    static NSInteger lastSection = 0;
    
    //判断手势落点位置是否在row上
    CGPoint longPressLocationPoint = [moveLongPressGR locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:longPressLocationPoint];
    switch (moveLongPressGR.state) {
        case UIGestureRecognizerStateBegan:
        {
            //手势开始
            if (indexPath == nil) {
                //NSLog(@"手势落点位置没落在哪个indexPath位置上");
                break;
            }
            
            UICollectionViewCell *cell = [self cellForItemAtIndexPath:indexPath];
            [self bringSubviewToFront:cell];
            //iOS9 方法 移动cell
            [self beginInteractiveMovementForItemAtIndexPath:indexPath];
            fromSection = indexPath.section;
            lastSection = indexPath.section;
        
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            NSInteger toSection = 0;
            if (indexPath == nil) {
                toSection = lastSection;
            } else {
                toSection = indexPath.section;
            }
            lastSection = toSection;
            
            BOOL moveEnable = self.cjCheckCellMoveEnableBlock == nil || self.cjCheckCellMoveEnableBlock(fromSection, toSection);
            if (moveEnable) {
                //iOS9 方法 移动过程中随时更新cell位置
                [self updateInteractiveMovementTargetPosition:longPressLocationPoint];
            } else {
                NSString *message = [NSString stringWithFormat:@"不能从%zd区移动到%zd区", fromSection, toSection];
                NSLog(@"温馨提示:%@", message);
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            //手势结束
            //iOS9方法 移动结束后关闭cell移动
            [self endInteractiveMovement];
            [self __cjMoveEnd];
            break;
        }
        default:
        {
            //取消移动
            [self cancelInteractiveMovement];
            [self __cjMoveEnd];
            
            break;
        }
    }
}

@end
