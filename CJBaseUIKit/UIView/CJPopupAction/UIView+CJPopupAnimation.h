//
//  UIView+CJPopupAnimation.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 从哪个方向弹出
typedef NS_ENUM(NSUInteger, CJDirection) {
    CJDirectionTop = 0,         /**< 从顶部弹出 */
    CJDirectionLeft,
    CJDirectionBottom,
    CJDirectionRight
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJPopupAnimation) {
    
}

/*
 *  添加从哪个方向进来的动画
 *
 *  @param direction        从哪个方向进来的动画
 *  @param animateOffset    移动的距离（正数）
 *  @param completion       动画结束的回调
 */
- (void)cj_animateFromDirection:(CJDirection)direction
                  animateOffset:(CGFloat)animateOffset
                     completion:(void (^ __nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
