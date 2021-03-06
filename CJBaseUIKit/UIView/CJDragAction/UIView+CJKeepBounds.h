//
//  UIView+CJKeepBounds.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  限制本视图不移出其父视图或keyWindow

#import <UIKit/UIKit.h>

//①不仅能够满足view在superView上的黏合，②还能满足当该view是window时，在keyWindow上的黏合
@interface UIView (CJKeepBounds)

/*
 *  黏合区域(①当视图超出边界的时候，XY是否黏合最近边界;②当视图没超出边界的时候，X也会黏合最近边界)
 */
- (void)cjKeepBounds;

/*
 *  黏合区域（吸附时候：如果是view最大到其父视图的范围，如果是window最大到keyWindow）
 *
 *  @param boundEdgeInsets                  黏合区域（黏合时候与边界的边距，上下边界可以完全黏合的时候是UIEdgeInsetsZero）
 *  @param isKeepBoundsXYWhenBeyondBound    当视图超出边界的时候，XY是否黏合最近边界
 *  @param isKeepBoundsXWhenContaintInBound 当视图没超出边界的时候，X是否黏合最近边界
 *  @param isKeepBoundsYWhenContaintInBound 当视图没超出边界的时候，Y是否黏合最近边界
 */
- (void)cjKeepBoundsWithBoundEdgeInsets:(UIEdgeInsets)boundEdgeInsets
          isKeepBoundsXYWhenBeyondBound:(BOOL)isKeepBoundsXYWhenBeyondBound
       isKeepBoundsXWhenContaintInBound:(BOOL)isKeepBoundsXWhenContaintInBound
       isKeepBoundsYWhenContaintInBound:(BOOL)isKeepBoundsYWhenContaintInBound;

@end
