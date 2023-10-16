//
//  UIView+CQPopupOverlayAction.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CQPopupOverlayAction.h"
#import <CJOverlayView/CJBaseOverlayThemeManager.h>

#import <CJPopupCreater/CJBottomBlankView+ShowHide.h>
#import <CJPopupCreater/CJCenterBlankView+ShowHide.h>
#import <CJPopupCreater/CQEffectAndCornerHelper.h>
#import <CQPopupCreater_Base/CQBottomPanlineBlankView.h>

@implementation UIView (CQPopupOverlayAction)

#pragma mark - 从底部弹出当前ActionSheet视图的相关代码
#pragma mark Event
/*
 *  显示当前视图到window底部(以直角)
 *
 *  @param popupViewHeight              弹出视图的高度
 *  @param shouldAddPanAction           是否添加仿抖音评论的下拉拖动手势(附对于那些会弹出键盘的视图，一般设为NO，即不添加)
 */
- (void)cqOverlay_actionSheet_showWithHeight:(CGFloat)selfHeight
                          shouldAddPanAction:(BOOL)shouldAddPanAction
{
    /*
    UIView *popupView = self;
    CGFloat popupViewHeight = selfHeight;
    CJBottomBlankView *blankView = [[CJBottomBlankView alloc] initWithPopupView:popupView popupViewHeight:popupViewHeight tapBlankHandle:^(CJBottomBlankView * _Nonnull bSelf) {
        [bSelf hideBlankViewSelf];
    }];
    [blankView addPanWithPanCompleteDismissBlock:^(CJBottomBlankView * _Nonnull bSelf) {
        [bSelf hideBlankViewSelf];
    }];

    [blankView showBlankViewSelfInView:nil];
    */

    
    // 1、创建自定义的视图【该视图为self本身，后面作为除下拉线外的视图来使用】
    UIView *withouPanlineView = self;
    CGFloat withoutPanlineViewHeight = selfHeight;
    
    // 2、通过上述创建的视图创建【包含着有下拉线panline视图的popupView弹出视图的blankView空白视图】
    CQBottomPanlineBlankView *blankView = [[CQBottomPanlineBlankView alloc] initWithShowPanLine:shouldAddPanAction customViewWithoutPanline:withouPanlineView customViewWithoutPanlineHeight:withoutPanlineViewHeight panCompleteDismissBlock:^(CQBottomPanlineBlankView * _Nonnull bBlankView) {
        [bBlankView hideBlankViewSelf];
    } tapBlankHandle:^(CQBottomPanlineBlankView * _Nonnull bBlankView) {
        [bBlankView hideBlankViewSelf];
    }];
    //*/
    
    
    // 2.其他 添加效果
    [blankView effectAndCornerWithEffectViewPart:CQBottomBlankAndPanlinePopupPartBlankView
                                     effectStyle:CQEffectStyleBGColor
                                  cornerViewPart:CQBottomBlankAndPanlinePopupPartPopupViewWithoutPanLine];
    
    
    
    
    // 3、将【背景视图blankView】添加到【你想要显示在的视图popupSuperview】中
    [blankView showBlankViewSelfInView:nil];
}


/*
 *  从window底部隐藏当前视图
 */
- (void)cqOverlay_actionSheet_hide {
    //UIView *popupView = self;
    UIView *popupView = self.superview;
    
    CJBottomBlankView *blankView = (CJBottomBlankView *)popupView.superview;
    [blankView hideBlankViewSelf];
}




#pragma mark - 从window中间弹出当前Alert视图的相关代码
/*
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cqOverlay_alert_showWithHeight:(CGFloat)popupViewHeight {
    // 执行显示弹窗的方法
    CJAlertThemeModel *alertThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
    CGFloat popupViewWidth = alertThemeModel.alertWidth;
    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    
    [self cqOverlay_alert_showWithSize:popupViewSize tapBlankShouldHide:YES];
}

/*
 *  显示当前视图到window中间
 *
 *  @param popupViewSize            弹出视图的大小
 *  @param tapBlankShouldHide       点击背景是否应该隐藏
 */
- (void)cqOverlay_alert_showWithSize:(CGSize)popupViewSize
                  tapBlankShouldHide:(BOOL)tapBlankShouldHide
{
    //__weak typeof(self)weakSelf = self;
    // 1、创建自定义的视图【该视图为self本身，后面作为弹出视图popupView来使用】
    UIView *popupView = self;
    
    // 2、通过上述创建的视图创建【包含着popupView弹出视图的blankView空白视图】
    CJCenterBlankView *blankView = [[CJCenterBlankView alloc] initWithPopupView:popupView popupViewSize:popupViewSize popupCenterOffset:CGPointZero tapBlankHandle:^(CJCenterBlankView * _Nonnull bSelf) {
        if (tapBlankShouldHide) {
            [bSelf hideBlankViewSelf];
        }
    }];
    
    // 2.其他 添加效果
    [CQEffectAndCornerHelper createEffectViewWithEffectStyle:CQEffectStyleBGColor
                                      newEffectViewAddToView:blankView
                             newEffectViewCloseToViewSubView:blankView];
    
    // 3、将【背景视图blankView】添加到【你想要显示在的视图popupSuperview】中
    [blankView showBlankViewSelfInView:nil];
}


/*
 *  从window中间隐藏当前视图
 */
- (void)cqOverlay_alert_hide {
    UIView *popupView = self;
    CJBottomBlankView *blankView = (CJBottomBlankView *)popupView.superview;
    [blankView hideBlankViewSelf];
}

@end
