//
//  UIView+CJPopupSuperviewSubview.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//
//  隐藏及显示弹出到popupSuperview的视图

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJPopupSuperviewSubview) {
    
}
//@property (nonatomic, strong) NSMutableArray<UIView *> *cjPopupSuperviewSubview;    /**< 弹出到popupSuperview的所有子视图 */
#pragma mark - 添加弹窗容器（用于管理控制弹窗的显示和隐藏）
/*
 *  在本视图上添加popupContainer，并返回它是第几个添加到此视图上的
 *  @brief  （使用场景：有时候只有第一个添加的才允许背景设置，以此来避免弹出多个有背景的弹窗，导致模糊度叠加)
 *
 *  @param popupContainer 要添加的视图
 *
 *  @return 所添加的视图，是第几个添加到此视图上的
 */
- (NSInteger)showPopupContainer:(UIView *)popupContainer;
- (void)hidePopupContainer:(UIView *)popupContainer;

#pragma mark - Event:【window上的弹窗】的显示与隐藏
/// 隐藏弹出到window视图的弹窗
+ (void)hideWindowPopupViews;

/// 重新显示弹出到window视图的弹窗
+ (void)reshowWindowPopupViews;

#pragma mark - Event:【当前view视图上的弹窗】的显示与隐藏
/// 隐藏弹出在本视图的弹窗
- (void)hidePopupViewsShowInCurrent;

/// 重新显示弹出到本视图的弹窗
- (void)reshowPopupViewsHideFromCurrent;

@end

NS_ASSUME_NONNULL_END
