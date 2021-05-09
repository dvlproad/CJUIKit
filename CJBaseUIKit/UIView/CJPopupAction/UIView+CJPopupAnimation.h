//
//  UIView+CJPopupAnimation.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewAnimateEnum.h"

typedef NS_ENUM(NSUInteger, CJAnimationType) {
    //    MJPopupViewAnimationFade = 0,
    //    MJPopupViewAnimationSlideBottomTop = 1,
    //    MJPopupViewAnimationSlideBottomBottom,
    //    MJPopupViewAnimationSlideTopTop,
    //    MJPopupViewAnimationSlideTopBottom,
    //    MJPopupViewAnimationSlideLeftLeft,
    //    MJPopupViewAnimationSlideLeftRight,
    //    MJPopupViewAnimationSlideRightLeft,
    //    MJPopupViewAnimationSlideRightRight,
    CJAnimationTypeNone = 0,   //Directly
    CJAnimationTypeNormal,     //通过设置frame来实现
    CJAnimationTypeCATransform3D
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJPopupAnimation) {
    
}
@property (nonatomic, assign) CJDirection cjShowFromDirection;  /**< 如果是显示的话，是从哪个方向进来的(关闭的时候回到对应的方向) */

/*
 *  弹出视图
 *
 *  @param popupViewShowFrame   popupViewShowFrame
 *  @param isToBottom           isToBottom
 *  @param animationType        animationType
 *  @param showComplete         showComplete
 */
- (void)cj_animateToShowFrame:(CGRect)popupViewShowFrame
                   isToBottom:(BOOL)isToBottom
                animationType:(CJAnimationType)animationType
                 showComplete:(void(^ _Nullable)(void))showComplete;

/**
 *  隐藏弹出视图
 */
- (void)cj_hidePopupView;
- (void)cj_hidePopupViewWithAnimationType:(CJAnimationType)animationType;

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
