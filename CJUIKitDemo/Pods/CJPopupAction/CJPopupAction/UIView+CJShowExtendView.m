//
//  UIView+CJShowExtendView.m
//  CJPopupViewDemo
//
//  Created by lichq on 15/11/12.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import "UIView+CJShowExtendView.h"

static NSString *cjExtendViewKey = @"cjExtendView";


@interface UIView ()

@property (nonatomic, strong) UIView *cjExtendView; /**< 当前视图的弹出视图 */

@end

@implementation UIView (CJShowDropView)

#pragma mark - runtime
//cjExtendView
- (UIView *)cjExtendView {
    return objc_getAssociatedObject(self, &cjExtendViewKey);
}

- (void)setCjExtendView:(UIView *)cjExtendView {
    return objc_setAssociatedObject(self, &cjExtendViewKey, cjExtendView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - <#Section#>
/** 完整的描述请参见文件头部 */
- (void)cj_showExtendView:(UIView *)popupView
                   inView:(UIView *)popupSuperview
               atLocation:(CGPoint)popupViewLocation
                 withSize:(CGSize)popupViewSize
             showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
         tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock
{
    self.cjExtendView = popupView;
    
    [popupView cj_popupInView:popupSuperview
                   atLocation:popupViewLocation
                     withSize:popupViewSize
                 showComplete:showPopupViewCompleteBlock
             tapBlankComplete:tapBlankViewCompleteBlock];
}

/** 完整的描述请参见文件头部 */
- (void)cj_showExtendView:(UIView *)popupView
                   inView:(UIView *)popupSuperview
    locationAccordingView:(UIView *)accordingView
         relativePosition:(CJPopupViewPosition)popupViewPosition
             showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
         tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock
{
    NSAssert(accordingView != nil, @"accordingView不能为空,如果为空，请选择 -cj_showExtendView:inView:atLocation:withSize:showComplete:tapBlankComplete:hideComplete:方法");
    
    self.cjExtendView = popupView;
    
    //accordingView在popupView的superview中对应的y、rect值为：
    CGRect accordingViewFrameInHisSuperview = [accordingView.superview convertRect:accordingView.frame toView:popupSuperview];
    //NSLog(@"accordingViewFrameInHisSuperview = %@", NSStringFromCGRect(accordingViewFrameInHisSuperview));
    CGPoint popupViewLocation = CGPointZero;
    CGSize popupViewSize = CGSizeZero;
    if (popupViewPosition == CJPopupViewPositionUnder) {
        CGFloat popupViewX = CGRectGetMinX(accordingViewFrameInHisSuperview);
        CGFloat popupViewY = CGRectGetMinY(accordingViewFrameInHisSuperview) + CGRectGetHeight(accordingView.frame);
        popupViewLocation = CGPointMake(popupViewX, popupViewY);
        
        CGFloat popupViewWidth = CGRectGetWidth(accordingView.frame);
        CGFloat popupViewHeight = CGRectGetHeight(popupView.frame);
        NSAssert(popupViewHeight != 0, @"弹出视图的高度不能为0");
        
        popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    }
    
    [popupView cj_popupInView:popupSuperview
                   atLocation:popupViewLocation
                     withSize:popupViewSize
                 showComplete:showPopupViewCompleteBlock
             tapBlankComplete:tapBlankViewCompleteBlock];
}


/** 完整的描述请参见文件头部 */
- (void)cj_hideExtendViewAnimated:(BOOL)animated {
    if (animated) {
        [self.cjExtendView cj_hidePopupViewWithAnimationType:CJAnimationTypeNormal];
    } else {
        [self.cjExtendView cj_hidePopupViewWithAnimationType:CJAnimationTypeNone];
    }
}

@end
