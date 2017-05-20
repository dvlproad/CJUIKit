//
//  UIView+CJKeepBounds.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CJKeepBounds)

/**
 *  黏合区域
 */
- (void)cjKeepBounds;

/**
 *  黏合区域
 *
 *  @param boundEdgeInsets                  黏合区域
 *  @param isKeepBoundsXYWhenBeyondBound    当视图超出边界的时候，XY是否黏合最近边界
 *  @param isKeepBoundsXWhenContaintInBound 当视图没超出边界的时候，X是否黏合最近边界
 */
- (void)cjKeepBoundsWithBoundEdgeInsets:(UIEdgeInsets)boundEdgeInsets
          isKeepBoundsXYWhenBeyondBound:(BOOL)isKeepBoundsXYWhenBeyondBound
       isKeepBoundsXWhenContaintInBound:(BOOL)isKeepBoundsXWhenContaintInBound;

@end
