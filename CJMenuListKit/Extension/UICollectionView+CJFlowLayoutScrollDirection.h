//
//  UICollectionView+CJFlowLayoutScrollDirection.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/4/8.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (CJFlowLayoutScrollDirection)

//可选设置的值，不设置采用默认
@property (nonatomic) UICollectionViewScrollDirection cjScrollDirection;  /**< 设置滚动方向(默认水平滚动) */

@end

NS_ASSUME_NONNULL_END
