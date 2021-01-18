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


#pragma mark - Event
/// 隐藏弹出到本视图的弹窗
- (void)hideWindowPopupViews {
    [self __showWindowPopupViews:NO];
}

/// 重新显示弹出到本视图的弹窗
- (void)reshowWindowPopupViews {
    [self __showWindowPopupViews:YES];
}



- (void)__showWindowPopupViews:(BOOL)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    NSArray *subViews1 = keyWindow.subviews;
    NSInteger subViewCount1 = subViews1.count;
    for (NSInteger i = 1; i < subViewCount1; i++) {
        UIView *view = subViews1[i];
        NSLog(@"view = %@", view);
    }
    
    NSArray *subViews2 = keyWindow.cjPopupSuperviewSubview;
    NSInteger subViewCount2 = subViews2.count;
    for (NSInteger i = 0; i < subViewCount2; i++) {
        UIView *view = subViews2[i];
        NSLog(@"view = %@", view);
        view.hidden = !show;
    }
}



@end
