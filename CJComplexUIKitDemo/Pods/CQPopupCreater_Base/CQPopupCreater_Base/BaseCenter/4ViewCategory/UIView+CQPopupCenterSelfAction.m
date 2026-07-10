//
//  UIView+CQPopupCenterSelfAction.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CQPopupCenterSelfAction.h"
#import "CJCenterBlankView+ShowHide.h"
#import "CQCenterBlankView.h"

@implementation UIView (CQPopupCenterSelfAction)



#pragma mark - 从window中间弹出当前视图的相关代码

#pragma mark Event

- (void)cqPopup_center_showInView:(nullable UIView *)popupSuperview
                       withHeight:(CGFloat)popupViewHeight
{
    CGSize popupViewSize = CGSizeMake(290, popupViewHeight);
    CGPoint centerOffset = CGPointMake(0, 0);
    [self cqPopup_center_showInView:popupSuperview withSize:popupViewSize centerOffset:centerOffset effectStyle:CQEffectStyleNone tapBlankShouldHide:YES];
}

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
               tapBlankShouldHide:(BOOL)tapBlankShouldHide
{
    __weak typeof(self)weakSelf = self;
    // 1、创建自定义的视图【该视图为self本身，后面作为弹出视图popupView来使用】
    UIView *popupView = self;
    
    // 2、通过上述创建的视图创建【包含着popupView弹出视图的blankView空白视图】
    CQCenterBlankView *blankView = [[CQCenterBlankView alloc] initWithPopupView:popupView popupViewSize:popupViewSize popupCenterOffset:centerOffset tapBlankHandle:^(CJCenterBlankView * _Nonnull bSelf) {
        if (tapBlankShouldHide) {
            [weakSelf cqPopup_center_hide];
        }
    }];
    [blankView effectAndCornerWithEffectViewPart:CQCenterBlankAndNormalPopupPartBlankView
                                     effectStyle:effectStyle
                                  cornerViewPart:CQCenterBlankAndNormalPopupPartNone];
    
    [blankView showBlankViewSelfInView:popupSuperview];
}


/*
 *  从window中间隐藏当前视图
 */
- (void)cqPopup_center_hide {
    CQCenterBlankView *blankView = [self __cqPopup_center_getSelfBlankView];
    [blankView hideBlankViewSelf];
}

#pragma mark - Private Method
- (CQCenterBlankView *)__cqPopup_center_getSelfBlankView {
    UIView *popupView = self;
    CQCenterBlankView *blankView = (CQCenterBlankView *)popupView.superview;
    return blankView;
}

@end
