//
//  UIView+CJDemoPopupAction.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIView+CJDemoPopupAction.h"
#import "UIView+CJRounderCorner.h"

@implementation UIView (CJDemoPopupAction)

/**
 *  显示当前视图到window底部
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)luckin_popupInBottomWithHeight:(CGFloat)popupViewHeight {
    self.layer.cornerRadius = 10;
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);
    
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGFloat popupViewWidth = CGRectGetWidth(keyWindow.frame) - edgeInsets.left - edgeInsets.right;
//    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
//    [self cj_addRounderCornerWithRadius:10
//                                   size:popupViewSize
//                        backgroundColor:[UIColor orangeColor]
//                            borderWidth:4
//                            borderColor:[UIColor purpleColor]
//     ];
    
    [self cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:edgeInsets blankBGColor:blankBGColor showComplete:nil tapBlankComplete:^{
        [self luckin_hidePopupView];
    }];
}

/**
 *  显示当前视图到window中间
 *
 *  @param popupViewHeight              弹出视图的高度
 */
- (void)luckin_popupInCenterWithHeight:(CGFloat)popupViewHeight {
    self.layer.cornerRadius = 10;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize popupViewSize = CGSizeMake(screenWidth-15, popupViewHeight);
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    
    [self cj_popupInCenterWindow:CJAnimationTypeNormal withSize:popupViewSize blankBGColor:blankBGColor showComplete:nil tapBlankComplete:^{
        [self luckin_hidePopupView];
    }];
}

/**
 *  隐藏弹出视图
 */
- (void)luckin_hidePopupView {
    [self cj_hidePopupView];
}

@end
