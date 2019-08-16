//
//  UIView+CJDemoPopupAction.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CJPopupInView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJDemoPopupAction)

/**
 *  显示当前视图到window底部
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)luckin_popupInBottomWithHeight:(CGFloat)popupViewHeight;

/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)luckin_popupInCenterWithHeight:(CGFloat)popupViewHeight;

/**
 *  隐藏弹出视图
 */
- (void)luckin_hidePopupView;


@end

NS_ASSUME_NONNULL_END
