//
//  UIView+CJPopupAnimation.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupAnimation.h"

@implementation UIView (CJPopupAnimation)

/*
 *  添加从哪个方向进来的动画
 *
 *  @param direction        从哪个方向进来的动画
 *  @param animateOffset    移动的距离（正数）
 *  @param completion       动画结束的回调
 */
- (void)cj_animateFromDirection:(CJDirection)direction
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
    
    CGAffineTransform transform;
    if (direction == CJDirectionTop) {
        transform = CGAffineTransformMakeTranslation(0, -animateOffset);
    } else if (direction == CJDirectionBottom) {
        transform = CGAffineTransformMakeTranslation(0, animateOffset);
    } else if (direction == CJDirectionLeft) {
        transform = CGAffineTransformMakeTranslation(0, -animateOffset);
    } else if (direction == CJDirectionRight) {
        transform = CGAffineTransformMakeTranslation(0, animateOffset);
    } else {
        transform = CGAffineTransformMakeTranslation(0, animateOffset);
    }
    
    self.transform = transform;
    
    self.alpha = 0;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
        
    } completion:completion];
}

@end
