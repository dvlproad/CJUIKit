//
//  UIView+CQPopupBottomPanlineAction.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CQPopupBottomPanlineAction.h"
#import "CQBottomPanlineBlankViewFactory.h"

#import "CQBottomCustomWithPanlineView.h"

@implementation UIView (CQPopupBottomPanlineAction)

#pragma mark - 从底部弹出当前视图的相关代码

#pragma mark Event
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
                       panCompleteDismissBlock:(void(^ _Nullable)(void))panCompleteDismissBlock
{
//    CQBottomPanlineBlankView *blankView =
//    [CQBottomPanlineBlankViewFactory blankViewWithCustomView:self
//                                            customViewHeight:selfHeight
//                                        shouldEnableTapBlank:YES
//                                            tapBlankComplete:tapBlankViewCompleteBlock
//                                          shouldAddPanAction:shouldAddPanAction
//                                     panCompleteDismissBlock:panCompleteDismissBlock];
    ///*
    // 1、创建自定义的视图【该视图为self本身，后面作为除下拉线外的视图来使用】
    UIView *withouPanlineView = self;
    CGFloat withoutPanlineViewHeight = selfHeight;
    
    // 2、通过上述创建的视图创建【包含着有下拉线panline视图的popupView弹出视图的blankView空白视图】
    CQBottomPanlineBlankView *blankView = [[CQBottomPanlineBlankView alloc] initWithShowPanLine:shouldAddPanAction customViewWithoutPanline:withouPanlineView customViewWithoutPanlineHeight:withoutPanlineViewHeight panCompleteDismissBlock:^(CQBottomPanlineBlankView * _Nonnull bBlankView) {
        if (panCompleteDismissBlock) {
            panCompleteDismissBlock();
        } else {
            [self cqPopup_bottom_with_panline_hide];
        }

    } tapBlankHandle:^(CQBottomPanlineBlankView * _Nonnull bBlankView) {
        // 设置点击空白区域的方法
        if (shouldEnableTapBlank == NO) {
            return;
        }
        if (tapBlankViewCompleteBlock) {
            tapBlankViewCompleteBlock();
        } else {
            [self cqPopup_bottom_with_panline_hide];
        }
    }];
    //*/
    
    
    // 2.其他 添加效果
    [blankView effectAndCornerWithEffectViewPart:effectViewPart effectStyle:effectStyle cornerViewPart:cornerViewPart];
    
    
    
    
    // 3、将【背景视图blankView】添加到【你想要显示在的视图popupSuperview】中
    [blankView showBlankViewSelfInView:popupSuperview];
}

/*
 *  从window底部隐藏当前视图
 */
- (void)cqPopup_bottom_with_panline_hide {
    CJBottomBlankView *blankView = [self __cqPopup_bottom_with_panline_getSelfBlankView];
    [blankView hideBlankViewSelf];
}




#pragma mark - Get View(比较少用)

// 最后的实际弹窗（目前的使用场景：弹出的视图中包含文本框，需要通过此属性来注册通知，从而在键盘弹出和不弹出时候显示在弹框中的不同位置）
- (UIView *)cqPopup_bottom_with_panline_realPopupView {
    CJBottomBlankView *blankView = [self __cqPopup_bottom_with_panline_getSelfBlankView];
    CQBottomCustomWithPanlineView *popupView = (CQBottomCustomWithPanlineView *)blankView.popupView;
    return popupView;
}


#pragma mark - Update SelfHeight(比较少用)
/*
 *  更新popupView视图的高度，内部会同时更新realPopupView的高度（常使用带有输入文本框的弹出视图，随着输入内容的长度变化，高度会变化）
 *  @brief: 此方法的调用者为除toolbar外的那个popupView(非realPopupView)
 *
 *  @param selfHeight                   本视图未加顶部下拉线时候的干净高度
 （即使本视图最终是由其他视图包着弹出,这里也只输入本视图被干净弹出的高度,实际最终的弹窗高度,内部会自动计算后以最终高度弹出)
 */
- (void)cqPopup_bottom_with_panline_updateViewWithoutPanLineHeight:(CGFloat)selfHeight {
    CJBottomBlankView *blankView = [self __cqPopup_bottom_with_panline_getSelfBlankView];
    CQBottomCustomWithPanlineView *popupView = (CQBottomCustomWithPanlineView *)blankView.popupView;
    CGFloat popupViewHeight = [popupView viewHeightWithCustomViewHeight:selfHeight];
    
    [blankView updatePopupViewHeight:popupViewHeight];
}


#pragma mark - Private Method
- (CJBottomBlankView *)__cqPopup_bottom_with_panline_getSelfBlankView {
    UIView *customView = self;
    UIView *viewWithoutPanline = customView;
    
    CQBottomCustomWithPanlineView *popupView = (CQBottomCustomWithPanlineView *)viewWithoutPanline.superview;
    CJBottomBlankView *blankView = (CJBottomBlankView *)popupView.superview;
    return blankView;
}


@end
