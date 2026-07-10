//
//  UIWindow+CJShareLoadingHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIWindow+CJShareLoadingHUD.h"
#import <objc/runtime.h>

@interface UIWindow () {
    
}
@property (nonatomic, strong) UIView *cjShareHUDBackgroundView;

@end


@implementation UIWindow (CJShareLoadingHUD)

//cjShareProgressHUD
- (UIView *)cjShareProgressHUD {
    return objc_getAssociatedObject(self, @selector(cjShareProgressHUD));
}

- (void)setCjShareProgressHUD:(UIView *)cjShareProgressHUD {
    objc_setAssociatedObject(self, @selector(cjShareProgressHUD), cjShareProgressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjShareHUDBackgroundView
- (UIView *)cjShareHUDBackgroundView {
    return objc_getAssociatedObject(self, @selector(cjShareHUDBackgroundView));
}

- (void)setCjShareHUDBackgroundView:(UIView *)cjShareHUDBackgroundView {
    objc_setAssociatedObject(self, @selector(cjShareHUDBackgroundView), cjShareHUDBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*
*  为本view添加HUD
*
*  @param progressHUD       要给当前view添加的HUD
*  @param showingStateOperateEnable    在hud显示的时候当前view是否可进行其他操作(YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作)
*/
- (void)cj_addShareProgressHUD:(UIView *)progressHUD
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
            self.cjShareHUDBackgroundView = bgView;
        }
        
        if (progressHUD == self.cjShareProgressHUD) {
            return;
        }
        NSLog(@"添加视图了%p\n", progressHUD);
        [self addSubview:progressHUD];
        self.cjShareProgressHUD = progressHUD;
    }
}

/// 移除本view上之前添加的HUD
- (void)cj_removeShareProgressHUD {
    if (self.cjShareHUDBackgroundView) {
        [self.cjShareHUDBackgroundView removeFromSuperview];
        self.cjShareHUDBackgroundView = nil;
    }
    
    if (self.cjShareProgressHUD) {
        [self.cjShareProgressHUD removeFromSuperview];
        self.cjShareProgressHUD = nil;
    }
}


@end
