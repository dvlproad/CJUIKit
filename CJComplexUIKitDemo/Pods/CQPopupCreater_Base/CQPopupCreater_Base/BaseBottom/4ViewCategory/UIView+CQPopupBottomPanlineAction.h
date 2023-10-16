//
//  UIView+CQPopupBottomPanlineAction.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  一个包着①自身和②【公共的顶部的PanLine（可定义是否添加）】的【容器视图】来作为最终视图弹出

#import <UIKit/UIKit.h>
#import <CJPopupCreater/CQEffectAndCornerHelper.h>
#import <CQPopupCreater_Base/CQBottomBlankAndPanlinePopupEnum.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CQPopupBottomPanlineAction) {
    
}

#pragma mark - 从底部弹出当前视图的相关代码
/*
 *  显示当前视图到window底部(可自定制点击空白区域执行的是确认还是取消操作)
 *
 *  @param popupSuperview               弹出视图的父视图view(如果为nil，则会弹出到window上)
 *  @param selfHeight                   本视图被干净弹出的高度
            （即使本视图最终是由其他视图包着弹出,这里也只输入本视图被干净弹出的高度,实际最终的弹窗高度,内部会自动计算后以最终高度弹出)
 *  @param cornerViewPart               圆角化（注:如果圆角的区域刚好等于被进行模糊的区域，则模糊的区域也要圆角）
 *  @param effectViewPart               要添加模糊化的是视图的哪个部分
 *  @param effectStyle                  要添加的模糊效果是【什么类型】
 *  @param shouldEnableTapBlank         是否允许点击空白区域（常设为YES，来实现点击空白区域来隐藏弹窗的功能）
 *  @param tapBlankViewCompleteBlock    当允许点击空白区域时候的执行事件(为nil时，点击会自动隐藏；非nil时候需要自己调用隐藏)
 *  @param shouldAddPanAction           是否添加仿抖音评论的下拉拖动手势(附对于那些会弹出键盘的视图，一般设为NO，即不添加)
 *  @param panCompleteDismissBlock      拖动结束需要执行dimiss的回调(shouldAddPanAction为NO的时候，此值无效，相当于设为nil)
 */
- (void)cqPopup_bottom_with_panline_showInView:(nullable UIView *)popupSuperview
                                    withHeight:(CGFloat)selfHeight
                                cornerViewPart:(CQBottomBlankAndPanlinePopupPart)cornerViewPart
                                effectViewPart:(CQBottomBlankAndPanlinePopupPart)effectViewPart
                                   effectStyle:(CQEffectStyle)effectStyle
                          shouldEnableTapBlank:(BOOL)shouldEnableTapBlank
                              tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock
                            shouldAddPanAction:(BOOL)shouldAddPanAction
                       panCompleteDismissBlock:(void(^ _Nullable)(void))panCompleteDismissBlock;

/// 从window底部隐藏当前视图
- (void)cqPopup_bottom_with_panline_hide;


#pragma mark - Get View(比较少用)

// 最后的实际弹窗（目前的使用场景：弹出的视图中包含文本框，需要通过此属性来注册通知，从而在键盘弹出和不弹出时候显示在弹框中的不同位置）
- (UIView *)cqPopup_bottom_with_panline_realPopupView;


#pragma mark - Update SelfHeight(比较少用)
/*
 *  更新视图的高度（常使用带有输入文本框的弹出视图，随着输入内容的长度变化，高度会变化）
 *
 *  @param viewHeightWithoutPanLine                   除去顶部下拉线之外的其他视图的高度
 （即使本视图最终是由其他视图包着弹出,这里也只输入本视图被干净弹出的高度,实际最终的弹窗高度,内部会自动计算后以最终高度弹出)
 */
- (void)cqPopup_bottom_with_panline_updateViewWithoutPanLineHeight:(CGFloat)viewHeightWithoutPanLine;


@end

NS_ASSUME_NONNULL_END
