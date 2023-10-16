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

#pragma mark - 从底部弹出当前ActionSheet视图的相关代码
#pragma mark Event
/*
 *  显示当前视图到window底部(以直角)
 *
 *  @param popupViewHeight              弹出视图的高度
 *  @param shouldAddPanAction           是否添加仿抖音评论的下拉拖动手势(附对于那些会弹出键盘的视图，一般设为NO，即不添加)
 */
- (void)cqOverlay_actionSheet_showWithHeight:(CGFloat)popupViewHeight
                          shouldAddPanAction:(BOOL)shouldAddPanAction;

/*
 *  从window底部隐藏当前视图
 */
- (void)cqOverlay_actionSheet_hide;


#pragma mark - 从window中间弹出当前Alert视图的相关代码
/*
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cqOverlay_alert_showWithHeight:(CGFloat)popupViewHeight;

/*
 *  显示当前视图到window中间
 *
 *  @param popupViewSize            弹出视图的大小
 *  @param tapBlankShouldHide       点击背景是否应该隐藏
 */
- (void)cqOverlay_alert_showWithSize:(CGSize)popupViewSize
                  tapBlankShouldHide:(BOOL)tapBlankShouldHide;

/*
 *  从window中间隐藏当前视图
 */
- (void)cqOverlay_alert_hide;
 
@end

NS_ASSUME_NONNULL_END
