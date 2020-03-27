//
//  CJHomeCollectionView+Move.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJHomeCollectionView+Move.h"
#import <objc/runtime.h>

static NSString * const cjIsBeginMoveKey = @"cjIsBeginMoveKey";
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

//cjIsBeginMove
- (BOOL)cjIsBeginMove {
    return [objc_getAssociatedObject(self, &cjIsBeginMoveKey) boolValue];
}

- (void)setCjIsBeginMove:(BOOL)cjIsBeginMove {
    objc_setAssociatedObject(self, &cjIsBeginMoveKey, @(cjIsBeginMove), OBJC_ASSOCIATION_ASSIGN);
}


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
            self.cjIsBeginMove = YES;
            [self removeGestureRecognizer:shakeLongPressGR];
            [self __addMoveGestureRecognizer];
            [self reloadData];
        
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

- (void)__addMoveGestureRecognizer {
    UILongPressGestureRecognizer *moveGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__moveGRAction:)];
    moveGR.minimumPressDuration = 0;
    [self addGestureRecognizer:moveGR];
    self.cjMoveGestureRecognizer = moveGR;
}
 
- (void)__moveGRAction:(UILongPressGestureRecognizer *)moveLongPressGR {
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
//            self.cjIsBeginMove = NO;
            break;
        }
        default:
        {
            //取消移动
            [self cancelInteractiveMovement];
//            self.cjIsBeginMove = NO;
            break;
        }
    }
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

@end
