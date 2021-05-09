//
//  UIView+CJPopupAnimation.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewAnimateEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJPopupAnimation) {
    
}
@property (nonatomic, assign) CJDirection cjShowFromDirection;  /**< 如果是显示的话，是从哪个方向进来的(关闭的时候回到对应的方向) */


/*
 *  添加从哪个方向进来的动画(变化过程透明度会从0到1)
 *
 *  @param forShow              显示还是隐藏
 *  @param showFromDirection    如果是显示的话，是从哪个方向进来的(关闭的时候回到对应的方向)
 *  @param animateOffset        移动的距离（正数）
 *  @param completion           动画结束的回调
 */
- (void)cj_animateForShow:(BOOL)forShow
        withShowDirection:(CJDirection)showFromDirection
            animateOffset:(CGFloat)animateOffset
               completion:(void (^ __nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
