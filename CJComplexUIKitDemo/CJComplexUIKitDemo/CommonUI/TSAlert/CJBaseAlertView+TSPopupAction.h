//
//  CJBaseAlertView+TSPopupAction.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <CJOverlayView/CJBaseAlertView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJBaseAlertView (TSPopupAction)

/*
*  显示弹窗
*
*  @param shouldFitHeight  是否自动适应高度
*/
- (void)showWithShouldFitHeight:(BOOL)shouldFitHeight;

/*
*  关闭弹窗
*
*  @param delay         多长时间后执行
*/
- (void)dismissAfterDelay:(CGFloat)delay;

@end

NS_ASSUME_NONNULL_END
