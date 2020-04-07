//
//  UIView+CJProgressHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIView+CJProgressHUD.h"
#import <objc/runtime.h>
#import "CJProgressHUD.h"

@interface UIView () {
    
}
@property (nonatomic, strong) CJProgressHUD *cj_progressHUD;
@property (nonatomic, strong) UIView *cjHUDBackgroundView;

@end


@implementation UIView (CJProgressHUD)

//cj_progressHUD
- (CJProgressHUD *)cj_progressHUD {
    return objc_getAssociatedObject(self, @selector(cj_progressHUD));
}

- (void)setCj_progressHUD:(CJProgressHUD *)cj_progressHUD {
    objc_setAssociatedObject(self, @selector(cj_progressHUD), cj_progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjHUDBackgroundView
- (UIView *)cjHUDBackgroundView {
    return objc_getAssociatedObject(self, @selector(cjHUDBackgroundView));
}

- (void)setCjHUDBackgroundView:(UIView *)cjHUDBackgroundView {
    objc_setAssociatedObject(self, @selector(cjHUDBackgroundView), cjHUDBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*
*  显示HUD
*
*  @param animationNamed    HUD的动画使用的json文件名
*  @param showBackground    YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作
*/
- (void)cj_showProgressHUDWithAnimationNamed:(NSString *)animationNamed showBackground:(BOOL)showBackground {
    if (showBackground) {
        CGFloat superViewWidth = CGRectGetWidth(self.frame);
        CGFloat superViewHeight = CGRectGetHeight(self.frame);
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor clearColor];
        bgView.frame = CGRectMake(0.0f, 0.0f, superViewWidth,  superViewHeight);
        [self addSubview:bgView];
        self.cjHUDBackgroundView = bgView;
    }
    
    if (!self.cj_progressHUD) {
        self.cj_progressHUD = [[CJProgressHUD alloc] initWithAnimationNamed:animationNamed];
        [self addSubview:self.cj_progressHUD];
    }
    
    [self.cj_progressHUD.lotAnimationView play];
}

/// 隐藏HUD
- (void)cj_dismissProgressHUD {
    if (self.cjHUDBackgroundView) {
        [self.cjHUDBackgroundView removeFromSuperview];
    }
    
    if (self.cj_progressHUD) {
        [self.cj_progressHUD.lotAnimationView stop];
        [self.cj_progressHUD removeFromSuperview];
        
//        self.cj_progressHUD = nil;
    }
}


@end
