//
//  UIView+CJDemoPopupAction.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CJDemoPopupAction.h"
#import "UIView+CJPopupInView.h"

static NSString *cjdemo_hidePopupViewBlockKey = @"cjdemo_hidePopupViewBlockKey";


@interface UIView () {
    
}

@end



@implementation UIView (CJDemoPopupAction)


#pragma mark - runtime
//cjdemo_hidePopupViewBlock
- (void (^)(void))cjdemo_hidePopupViewBlock {
    return objc_getAssociatedObject(self, &cjdemo_hidePopupViewBlockKey);
}

- (void)setCjdemo_hidePopupViewBlock:(void (^)(void))cjdemo_hidePopupViewBlock {
    return objc_setAssociatedObject(self, &cjdemo_hidePopupViewBlockKey, cjdemo_hidePopupViewBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cjdemo_popupInCenterWithHeight:(CGFloat)popupViewHeight {
    self.layer.cornerRadius = 10;
    
    //CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //CGFloat popupViewWidth = screenWidth-2*15;
    CGFloat popupViewWidth = 260;
    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    
    // 设置隐藏弹窗的方法
    __weak typeof(UIView *)weakPopupView = self;
    weakPopupView.cjdemo_hidePopupViewBlock = ^(void){
        [weakPopupView cj_hidePopupView];
    };
    // 执行显示弹窗的方法
    [self cj_popupInCenterWindow:CJAnimationTypeNormal withSize:popupViewSize centerOffset:CGPointZero blankViewCreateBlock:nil showComplete:nil tapBlankComplete:^{
        [self cjdemo_hidePopupView];
    }];
}

/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cjdemo_popupInDarkCenterWithHeight:(CGFloat)popupViewHeight {
    CGFloat popupViewWidth = 270;
    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    
    // 设置隐藏弹窗的方法
    __weak typeof(UIView *)weakPopupView = self;
    weakPopupView.cjdemo_hidePopupViewBlock = ^(void){
        [weakPopupView cj_hidePopupView];
    };
    // 执行显示弹窗的方法
    [self cj_popupInCenterWindow:CJAnimationTypeNormal withSize:popupViewSize centerOffset:CGPointZero blankViewCreateBlock:nil showComplete:nil tapBlankComplete:nil];
}


/**
 *  显示当前视图到window底部(以直角)
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cjdemo_popupInBottomWithHeight:(CGFloat)popupViewHeight {
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    
    // 设置隐藏弹窗的方法
    __weak typeof(UIView *)weakPopupView = self;
    weakPopupView.cjdemo_hidePopupViewBlock = ^(void){
        [weakPopupView cj_hidePopupView];
    };
    // 执行显示弹窗的方法
    [self cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:edgeInsets blankViewCreateBlock:nil showComplete:nil tapBlankComplete:^{
        [self cjdemo_hidePopupView];
    }];
}

/**
 *  显示当前视图到window底部(以圆角弧度)
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)cjdemo_popupInBottomCornerRadiusWithHeight:(CGFloat)popupViewHeight {
    self.layer.cornerRadius = 10;
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL isScreenFull = screenHeight >= 812 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;  // 是否是全面屏
    CGFloat screenBottomHeight = isScreenFull ?  34.0 : 0.0;    // 屏幕底部
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 10, screenBottomHeight+10, 10);
    
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGFloat popupViewWidth = CGRectGetWidth(keyWindow.frame) - edgeInsets.left - edgeInsets.right;
//    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
//    [self cj_addRounderCornerWithRadius:10
//                                   size:popupViewSize
//                        backgroundColor:[UIColor orangeColor]
//                            borderWidth:4
//                            borderColor:[UIColor purpleColor]
//     ];
    
    // 设置隐藏弹窗的方法
    __weak typeof(UIView *)weakPopupView = self;
    weakPopupView.cjdemo_hidePopupViewBlock = ^(void){
        [weakPopupView cj_hidePopupView];
    };
    // 执行显示弹窗的方法
    [self cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:edgeInsets blankViewCreateBlock:nil showComplete:nil tapBlankComplete:^{
        [self cjdemo_hidePopupView];
    }];
}



/**
 *  隐藏弹出视图
 */
- (void)cjdemo_hidePopupView {
    if (self.cjdemo_hidePopupViewBlock) {
        self.cjdemo_hidePopupViewBlock();
    }
}

@end
