//
//  CQLoadingHUD.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQLoadingHUD.h"

@interface CQLoadingHUD () {
    
}
//@property (nonatomic, strong) UIView *bgView;
//
//@property (nonatomic, assign, readonly) NSInteger callShowMethodCount;
//@property (nonatomic, assign, readonly) NSInteger callDismissMethodCount;


@end


@implementation CQLoadingHUD

- (void)play {
    [self.lotAnimationView play];
}

- (void)stop {
    [self.lotAnimationView stop];
}

///**
//*  显示HUD
//*
//*  @param superView                要添加到的视图
//*  @param showBackground    YES:加载过程无法进行其他操作，NO:加载过程可进行其他操作
//*/
//- (void)showInView:(UIView *)superView withShowBackground:(BOOL)showBackground {
//    _callShowMethodCount++;
//    if (superView == nil) {
//        superView = [UIApplication sharedApplication].keyWindow;
//    }
//
//    if (showBackground) {
//        CGFloat superViewWidth = CGRectGetWidth(superView.frame);
//        CGFloat superViewHeight = CGRectGetHeight(superView.frame);
//
//        if(self.bgView == nil){
//            self.bgView = [[UIView alloc] init];
//            self.bgView.backgroundColor = [UIColor clearColor];
//        }
//        self.bgView.frame = CGRectMake(0.0f, 0.0f, superViewWidth,  superViewHeight);
//        [superView addSubview:self.bgView];
//    }
//
//    [superView addSubview:self];
//    [self.lotAnimationView play];
//}
//
///**
// *  隐藏HUD(若非强制隐藏，则需要显示次数与隐藏次数一致时候才隐藏)
// *
// *  @param force 是否强制隐藏
// *
// *  return 执行完后是否就成功隐藏了
// */
//- (BOOL)dismissWithForce:(BOOL)force {
//    _callDismissMethodCount++;
//
//    BOOL shouldDismiss = YES;
//    if (!force && _callDismissMethodCount < _callShowMethodCount) {
//        shouldDismiss = NO;
//    }
//
//    if (shouldDismiss) {
//        [self.lotAnimationView stop];
//        [self removeFromSuperview];
//        if (self.bgView) {
//            [self.bgView removeFromSuperview];
//        }
//    }
//
//    return shouldDismiss;
//}
//




@end
