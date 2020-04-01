//
//  UIScrollView+CJAddFillView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2018/2/6.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CJAddFillView) {
    
}

/// 添加占满UIScrollView的视图(会同时更新ScrollView的ContentSize)
- (void)cj_addFillView:(UIView *)fillView;

/**
 *  set or update ScrollView ContentSize with fillView
 *
 *  @param sizeFromView     the contentSize width value from it
 *  @param bottomFromView   the contentSize height value from it.(if nil, the contentSize height will from sizeFromView)
 *  @param heighExceedValue the contentSize height more than bottomFromView(when bottomFromView is nil, mean more than sizeFromView)
 */
- (void)cj_setupContentSizeByView:(UIView *)sizeFromView
             exceptBottomFromView:(nullable UIView *)bottomFromView
                 heighExceedValue:(CGFloat)heighExceedValue;

@end

NS_ASSUME_NONNULL_END
