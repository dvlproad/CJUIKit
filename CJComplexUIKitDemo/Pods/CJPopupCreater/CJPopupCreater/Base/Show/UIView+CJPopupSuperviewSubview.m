//
//  UIView+CJPopupSuperviewSubview.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupSuperviewSubview.h"

@interface UIView ()

@end


@implementation UIView (CJPopupInView)

#pragma mark - runtime
#pragma mark - 弹出到popupSuperview的视图
// cjPopupSuperviewSubview
- (NSMutableArray<UIView *> *)cjPopupSuperviewSubview {
    return objc_getAssociatedObject(self, @selector(cjPopupSuperviewSubview));
}

- (void)setCjPopupSuperviewSubview:(NSMutableArray<UIView *> *)cjPopupSuperviewSubview {
    objc_setAssociatedObject(self, @selector(cjPopupSuperviewSubview), cjPopupSuperviewSubview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 添加弹窗容器（用于管理控制弹窗的显示和隐藏）
/*
 *  在本视图上添加popupContainer，并返回它是第几个添加到此视图上的
 *  @brief  （使用场景：有时候只有第一个添加的才允许背景设置，以此来避免弹出多个有背景的弹窗，导致模糊度叠加)
 *
 *  @param popupContainer 要添加的视图
 *
 *  @return 所添加的视图，是第几个添加到此视图上的
 */
- (NSInteger)showPopupContainer:(UIView *)popupContainer {
    //[self addSubview:popupContainer];
    [UIView cjPopup_makeView:self addSubView:popupContainer withEdgeInsets:UIEdgeInsetsZero];
    [popupContainer.superview layoutIfNeeded];  // 修复动画效果,以让popupContainer可以提前绘制
    
    if (self.cjPopupSuperviewSubview == nil) {
        self.cjPopupSuperviewSubview = [[NSMutableArray alloc] init];
    }
    [self.cjPopupSuperviewSubview addObject:popupContainer];
    
    NSInteger index = [self.cjPopupSuperviewSubview indexOfObject:popupContainer];
    return index;
}

- (void)hidePopupContainer:(UIView *)popupContainer {
    [popupContainer removeFromSuperview];
    
    if (self.cjPopupSuperviewSubview != nil) {
        [self.cjPopupSuperviewSubview removeObject:popupContainer];
    }
}


#pragma mark - Event:window上的弹窗的显示与隐藏
/// 隐藏弹出到window视图的弹窗
+ (void)hideWindowPopupViews {
    [self __showOrHideWindowPopupViews:NO];
}

/// 重新显示弹出到window视图的弹窗
+ (void)reshowWindowPopupViews {
    [self __showOrHideWindowPopupViews:YES];
}


+ (void)__showOrHideWindowPopupViews:(BOOL)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    NSArray *subViews1 = keyWindow.subviews;
    NSInteger subViewCount1 = subViews1.count;
    for (NSInteger i = 1; i < subViewCount1; i++) {
        UIView *view = subViews1[i];
        NSLog(@"view = %@", view);
    }
    
    [keyWindow __showOrHidePopupViews:show];
}



#pragma mark - Event:当前view视图上的弹窗的显示与隐藏
/// 隐藏弹出在本视图的弹窗
- (void)hidePopupViewsShowInCurrent {
    [self __showOrHidePopupViews:NO];
}

/// 重新显示弹出到本视图的弹窗
- (void)reshowPopupViewsHideFromCurrent {
    [self __showOrHidePopupViews:YES];
}


- (void)__showOrHidePopupViews:(BOOL)show {
    NSArray *subViews2 = self.cjPopupSuperviewSubview;
    NSInteger subViewCount2 = subViews2.count;
    for (NSInteger i = 0; i < subViewCount2; i++) {
        UIView *view = subViews2[i];
        //NSLog(@"要显示或隐藏的view = %@", view);
        view.hidden = !show;
    }
}

+ (void)cjPopup_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}


@end
