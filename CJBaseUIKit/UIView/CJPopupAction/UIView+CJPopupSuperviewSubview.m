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
        NSLog(@"view = %@", view);
        view.hidden = !show;
    }
}


@end
