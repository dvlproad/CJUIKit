//
//  UIView+CQPopupAction.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CQPopupAction) {
    
}
@property (nonatomic, copy) void(^cjdemo_hidePopupViewBlock)(void);  /**< 隐藏当前视图的方法 */

/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cjdemo_popupInCenterWithHeight:(CGFloat)popupViewHeight;

/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cjdemo_popupInDarkCenterWithHeight:(CGFloat)popupViewHeight;

/**
 *  显示当前视图到window底部(以直角)
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cjdemo_popupInBottomWithHeight:(CGFloat)popupViewHeight;

/**
 *  显示当前视图到window底部(以圆角弧度)
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cjdemo_popupInBottomCornerRadiusWithHeight:(CGFloat)popupViewHeight;

/**
 *  隐藏弹出视图
 */
- (void)cjdemo_hidePopupView;


@end

NS_ASSUME_NONNULL_END
