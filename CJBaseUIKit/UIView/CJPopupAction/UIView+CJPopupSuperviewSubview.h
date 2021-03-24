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
//@property (nonatomic, strong) UIView *cjTapView;    /**< 空白区域（指radioButtons组合下的点击区域（不包括radioButtons区域），用来点击之后隐藏列表） */
@property (nonatomic, strong) NSMutableArray<UIView *> *cjPopupSuperviewSubview;    /**< 弹出到popupSuperview的所有子视图 */

#pragma mark - Event:window上的弹窗的显示与隐藏
/// 隐藏弹出到window视图的弹窗
+ (void)hideWindowPopupViews;

/// 重新显示弹出到window视图的弹窗
+ (void)reshowWindowPopupViews;

#pragma mark - Event:当前view视图上的弹窗的显示与隐藏
/// 隐藏弹出在本视图的弹窗
- (void)hidePopupViewsShowInCurrent;

/// 重新显示弹出到本视图的弹窗
- (void)reshowPopupViewsHideFromCurrent;

@end

NS_ASSUME_NONNULL_END
