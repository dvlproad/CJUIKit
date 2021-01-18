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
@property (nonatomic, strong) NSMutableArray<UIView *> *cjPopupSuperviewSubview;    /**< 弹出到popupSuperview的视图 */

#pragma mark - Event
/// 隐藏弹出到本视图的弹窗
- (void)hideWindowPopupViews;

/// 重新显示弹出到本视图的弹窗
- (void)reshowWindowPopupViews;

@end

NS_ASSUME_NONNULL_END
