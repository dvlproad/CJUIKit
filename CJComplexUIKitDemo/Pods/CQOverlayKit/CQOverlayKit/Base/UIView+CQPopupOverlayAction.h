//
//  UIView+CQPopupOverlayAction.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CQPopupOverlayAction) {
    
}

#pragma mark - 从底部弹出当前视图的相关代码
/**
 *  显示当前视图到window底部(以直角)
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cqOverlay_popupInBottomWithHeight:(CGFloat)popupViewHeight;

/// 从window底部隐藏当前视图
- (void)cqOverlay_popupHideBottom;


#pragma mark - 从window中间弹出当前视图的相关代码
/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cqOverlay_popupInCenterWindowWithHeight:(CGFloat)popupViewHeight;

/// 从window中间隐藏当前视图
- (void)cqOverlay_popupHideCenter;


@end

NS_ASSUME_NONNULL_END
