//
//  UIView+CQPopupBottomSelfAction.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  一个只包着①自身的【自身视图】来作为最终视图弹出

#import <UIKit/UIKit.h>
#import <CJPopupCreater/CQEffectAndCornerHelper.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CQPopupBottomSelfAction) {
    
}

/*
 *  显示当前视图到window底部(可自定制点击空白区域执行的是确认还是取消操作)
 *
 *  @param popupSuperview               弹出视图的父视图view(如果为nil，则会弹出到window上)
 *  @param selfHeight                   本视图被干净弹出的高度
            （即使本视图最终是由其他视图包着弹出,这里也只输入本视图被干净弹出的高度,实际最终的弹窗高度,内部会自动计算后以最终高度弹出)
 *  @param effectStyle                  模糊类型
 *  @param shouldEnableTapBlank         是否允许点击空白区域（常设为YES，来实现点击空白区域来隐藏弹窗的功能）
 *  @param tapBlankViewCompleteBlock    当允许点击空白区域时候的执行事件(为nil时，点击会自动隐藏；非nil时候需要自己调用隐藏)
 *  @param shouldAddPanAction           是否添加仿抖音评论的下拉拖动手势(附对于那些会弹出键盘的视图，一般设为NO，即不添加)
 *  @param panCompleteDismissBlock      拖动结束需要执行dimiss的回调(shouldAddPanAction为NO的时候，此值无效，相当于设为nil)
 */
- (void)cqPopup_bottom_with_selfAlone_showInView:(nullable UIView *)popupSuperview
                                      withHeight:(CGFloat)selfHeight
                                     effectStyle:(CQEffectStyle)effectStyle
                            shouldEnableTapBlank:(BOOL)shouldEnableTapBlank
                                tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock
                              shouldAddPanAction:(BOOL)shouldAddPanAction
                         panCompleteDismissBlock:(void(^ _Nullable)(void))panCompleteDismissBlock;

/// 从window底部隐藏当前视图
- (void)cqPopup_bottom_with_selfAlone_hide;


@end

NS_ASSUME_NONNULL_END
