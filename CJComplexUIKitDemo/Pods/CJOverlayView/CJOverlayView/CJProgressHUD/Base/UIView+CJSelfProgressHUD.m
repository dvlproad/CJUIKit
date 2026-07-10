//
//  UIView+CJSelfProgressHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIView+CJSelfProgressHUD.h"
#import <objc/runtime.h>

@interface UIView () {
    
}
@property (nonatomic, strong) UIView *cjSelfHUDBackgroundView;

@end


@implementation UIView (CJSelfProgressHUD)

////cjProgressHUDShowing
//- (BOOL)cjProgressHUDShowing {
//    return [objc_getAssociatedObject(self, @selector(cjProgressHUDShowing)) integerValue];
//}
//
//- (void)setCjProgressHUDShowing:(BOOL)cjProgressHUDShowing {
//    objc_setAssociatedObject(self, @selector(cjProgressHUDShowing), @(cjProgressHUDShowing), OBJC_ASSOCIATION_ASSIGN);
//}

//cjSelfProgressHUD
- (UIView *)cjSelfProgressHUD {
    return objc_getAssociatedObject(self, @selector(cjSelfProgressHUD));
}

- (void)setCjSelfProgressHUD:(UIView *)cjSelfProgressHUD {
    objc_setAssociatedObject(self, @selector(cjSelfProgressHUD), cjSelfProgressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjSelfHUDBackgroundView
- (UIView *)cjSelfHUDBackgroundView {
    return objc_getAssociatedObject(self, @selector(cjSelfHUDBackgroundView));
}

- (void)setCjSelfHUDBackgroundView:(UIView *)cjSelfHUDBackgroundView {
    objc_setAssociatedObject(self, @selector(cjSelfHUDBackgroundView), cjSelfHUDBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*
*  为本view添加HUD
*
*  @param progressHUD                   要给当前view添加的HUD
*  @param showingStateOperateEnable     在hud显示的时候当前view是否可进行其他操作(YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作)
*/
- (void)cj_addSlefProgressHUD:(UIView *)progressHUD
    showingStateOperateEnable:(BOOL)showingStateOperateEnable
{
    @synchronized (self) {
        if (!showingStateOperateEnable) {
            CGFloat superViewWidth = CGRectGetWidth(self.frame);
            CGFloat superViewHeight = CGRectGetHeight(self.frame);
            
            UIView *bgView = [[UIView alloc] init];
            bgView.backgroundColor = [UIColor clearColor];
            bgView.frame = CGRectMake(0.0f, 0.0f, superViewWidth,  superViewHeight);
            [self addSubview:bgView];
            self.cjSelfHUDBackgroundView = bgView;
        }
        
        if (progressHUD == self.cjSelfProgressHUD) {
            return;
        }
        NSLog(@"添加视图了%p\n", progressHUD);
        [self addSubview:progressHUD];
        progressHUD.center = self.center;
        
        self.cjSelfProgressHUD = progressHUD;
    }
}

/// 移除本view上之前添加的HUD
- (void)cj_removeSelfProgressHUD {
    if (self.cjSelfHUDBackgroundView) {
        [self.cjSelfHUDBackgroundView removeFromSuperview];
        self.cjSelfHUDBackgroundView = nil;
    }
    
    if (self.cjSelfProgressHUD) {
        [self.cjSelfProgressHUD removeFromSuperview];
        self.cjSelfProgressHUD = nil;
    }
}


@end
