//
//  CJCenterBlankViewShowHelper.m
//  CQPopupCreater_Other
//
//  Created by ciyouzen on 2021/10/14.
//

#import "CJCenterBlankViewShowHelper.h"
#import <CJPopupCreater/UIView+CJPopupSuperviewSubview.h>

@implementation CJCenterBlankViewShowHelper

/*
 *  显示最完整弹窗视图blankView
 *
 *  @param blankView            要显示的含点击背景的最完整弹窗视图blankView
 *  @param popupSuperview       要显示在什么视图上(为nil时候，显示在keyWindow上)
 */
+ (void)__showBlankView:(CJCenterBlankView *)blankView inView:(nullable UIView *)popupSuperview {
    if (popupSuperview == nil) {
        popupSuperview = [[UIApplication sharedApplication] keyWindow];
    }
    NSInteger blankViewIndex = [popupSuperview showPopupContainer:blankView];
    
    [blankView updateConstraintsForPopupViewWithShow:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [blankView updateConstraintsForPopupViewWithShow:YES];
    } completion:nil];
}


/*
 *  隐藏最完整弹窗视图blankView
 *
 *  @param blankView            要隐藏的含点击背景的最完整弹窗视图blankView
 */
+ (void)__hideBlankView:(CJCenterBlankView *)blankView {
    // 注意：当正在关闭弹窗的时候，应该禁用整个视图的所有点击（防止尤其是当关闭耗时时候，多次进行的空白区域的快速点击导致重复调用）
    blankView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        [blankView updateConstraintsForPopupViewWithShow:NO];
        
    } completion:^(BOOL finished) {
        NSAssert(blankView.superview != nil, @"用于添加背景视图的父视图superview不能为nil");
        [blankView.superview hidePopupContainer:blankView];
    }];
}


@end
