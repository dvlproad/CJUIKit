//
//  UIView+CJPopupAnimation.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupAnimation.h"
#import <objc/runtime.h>

@implementation UIView (CJPopupAnimation)

#pragma mark - Runtime: Assign
- (CJDirection)cjShowFromDirection {
    return [objc_getAssociatedObject(self, @selector(cjShowFromDirection)) integerValue];
}

- (void)setCjShowFromDirection:(CJDirection)cjShowFromDirection {
    objc_setAssociatedObject(self, @selector(cjShowFromDirection), @(cjShowFromDirection), OBJC_ASSOCIATION_ASSIGN);
}

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
               completion:(void (^ __nullable)(BOOL finished))completion
{
    [self.superview layoutIfNeeded]; // 确保在使用如mas_makeConstraints的时候能够立马生成约束

    /*
    [UIView animateWithDuration:0.3f delay:3.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(cell.mas_top).mas_offset(-animateOffset);
//        }];
//        [self.superview layoutIfNeeded];
        self.transform = CGAffineTransformIdentity;
        
    } completion:nil];
     */
    
    if (forShow) {
        [self __updateTransformFromDirection:showFromDirection animateOffset:animateOffset];
        
        self.alpha = 0;
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
            self.alpha = 1;
            
        } completion:completion];
    } else {
        self.transform = CGAffineTransformIdentity;
        
        self.alpha = 1;
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self __updateTransformFromDirection:showFromDirection animateOffset:animateOffset];
            self.alpha = 0;
            
        } completion:completion];
    }
}

/*
 *  更新当前视图的位置到当前位置的direction方向上距离animateOffset的位置
 *
 *  @param direction direction
 *  @param animateOffset animateOffset
 */
- (void)__updateTransformFromDirection:(CJDirection)direction
                         animateOffset:(CGFloat)animateOffset
{
    CGAffineTransform transform;
    if (direction == CJDirectionTop) {              // 向上移动
        transform = CGAffineTransformMakeTranslation(0, -animateOffset);
    } else if (direction == CJDirectionBottom) {    // 向下移动
        transform = CGAffineTransformMakeTranslation(0, animateOffset);
    } else if (direction == CJDirectionLeft) {
        transform = CGAffineTransformMakeTranslation(0, -animateOffset);
    } else if (direction == CJDirectionRight) {
        transform = CGAffineTransformMakeTranslation(0, animateOffset);
    } else {
        transform = CGAffineTransformMakeTranslation(0, animateOffset);
    }
    
    self.transform = transform;
}


@end
