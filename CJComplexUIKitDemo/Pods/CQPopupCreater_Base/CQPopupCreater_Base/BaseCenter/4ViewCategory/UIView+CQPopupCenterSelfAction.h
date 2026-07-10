//
//  UIView+CQPopupCenterSelfAction.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJPopupCreater/CQEffectAndCornerHelper.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CQPopupCenterSelfAction) {
    
}

#pragma mark - 从window中间弹出当前视图的相关代码

- (void)cqPopup_center_showInView:(nullable UIView *)popupSuperview
                       withHeight:(CGFloat)popupViewHeight;

/*
 *  显示当前视图到window中间
 *
 *  @param popupSuperview           弹出视图的父视图view(如果为nil，则会弹出到window上)
 *  @param popupViewSize            弹出视图的大小
 *  @param centerOffset             弹窗弹出位置的中心与window中心的偏移量
 *  @param effectStyle              要添加的模糊效果是【什么类型】
 *  @param tapBlankShouldHide       点击背景是否应该隐藏
 */
- (void)cqPopup_center_showInView:(nullable UIView *)popupSuperview
                         withSize:(CGSize)popupViewSize
                     centerOffset:(CGPoint)centerOffset
                      effectStyle:(CQEffectStyle)effectStyle
               tapBlankShouldHide:(BOOL)tapBlankShouldHide;

/// 从window中间隐藏当前视图
- (void)cqPopup_center_hide;


@end

NS_ASSUME_NONNULL_END
