//
//  CJHomeCollectionView+Move.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJHomeCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJHomeCollectionView (Move) {
    
}
@property (nonatomic, copy) BOOL (^cjCheckSectionMoveEnableBlock)(NSIndexPath *indexPath);    /**< 设置允许哪些section中的哪些item进行拖动操作，默认都允许 */
@property (nonatomic, copy) BOOL (^cjCheckCellMoveEnableBlock)(NSInteger fromSection, NSInteger toSection);    /**< 检查是否允许跨secton操作，默认允许 */

/**
*  添加手势
*
*  @param containShakeGR   是否包含抖动手势
*/
- (void)addGestureRecognizerWithContainShakeGR:(BOOL)containShakeGR;

@end

NS_ASSUME_NONNULL_END
