//
//  UIView+CQPopupBottomSelfAction.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CQPopupBottomSelfAction.h"
#import <CJPopupCreater/CJBottomBlankView+ShowHide.h>

#import <CJPopupCreater/CQEffectViewFactory.h>

@interface UIView () {
    
}

@end



@implementation UIView (CQPopupBottomSelfAction)


#pragma mark - 从底部弹出当前视图的相关代码

#pragma mark Event
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
                         panCompleteDismissBlock:(void(^ _Nullable)(void))panCompleteDismissBlock
{
    // 1、创建【含下拉线的视图】
    UIView *popupView = self;
    CGFloat popupViewHeight = selfHeight;
    
    // 2、将【含下拉线的视图】添加到【背景视图blankView】中
    CJBottomBlankView *blankView = [[CJBottomBlankView alloc] initWithPopupView:popupView popupViewHeight:popupViewHeight tapBlankHandle:^(CJBasePopupBlankView * _Nonnull bSelf) {
        // 设置点击空白区域的方法
        if (shouldEnableTapBlank == NO) {
            return;
        }
        
        if (tapBlankViewCompleteBlock) {
            tapBlankViewCompleteBlock();
        } else {
            [self cqPopup_bottom_with_selfAlone_hide];
        }
    }];
    
    
    if (shouldAddPanAction) {
        [blankView addPanWithPanCompleteDismissBlock:^(CJBottomBlankView * _Nonnull bSelf) {
            if (panCompleteDismissBlock) {
                panCompleteDismissBlock();
            } else {
                [self cqPopup_bottom_with_selfAlone_hide];
            }
        }];
    }
    
    
    
    // 2.其他 添加效果
    //UIVisualEffectView *effectView =
        [CQEffectAndCornerHelper createEffectViewWithEffectStyle:effectStyle
                                          newEffectViewAddToView:blankView
                                 newEffectViewCloseToViewSubView:blankView];
    
    // 3、将【背景视图blankView】添加到【你想要显示在的视图popupSuperview】中
    [blankView showBlankViewSelfInView:popupSuperview];
}


/*
 *  从window底部隐藏当前视图
 */
- (void)cqPopup_bottom_with_selfAlone_hide {
    CJBottomBlankView *blankView = [self __cqPopup_bottom_with_selfAlone_getSelfBlankView];
    [blankView hideBlankViewSelf];
}



#pragma mark - Update(比较少用)

/*
 *  更新视图的高度（常使用带有输入文本框的弹出视图，随着输入内容的长度变化，高度会变化）
 *
 *  @param selfHeight                   本视图被干净弹出的高度
 （即使本视图最终是由其他视图包着弹出,这里也只输入本视图被干净弹出的高度,实际最终的弹窗高度,内部会自动计算后以最终高度弹出)
 */
- (void)cqPopup_bottom_with_selfAlone_updateHeight:(CGFloat)selfHeight {
    CJBottomBlankView *blankView = [self __cqPopup_bottom_with_selfAlone_getSelfBlankView];
    CGFloat popupViewHeight = selfHeight;
    
    [blankView updatePopupViewHeight:popupViewHeight];
}



#pragma mark - Private Method
- (CJBottomBlankView *)__cqPopup_bottom_with_selfAlone_getSelfBlankView {
    UIView *popupView = self;
    CJBottomBlankView *blankView = (CJBottomBlankView *)popupView.superview;
    return blankView;
}



@end
