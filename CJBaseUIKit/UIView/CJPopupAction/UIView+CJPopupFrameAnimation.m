//
//  UIView+CJPopupFrameAnimation.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupFrameAnimation.h"
#import <objc/runtime.h>
#import "UIView+CJPopupSuperviewSubview.h"

static CGFloat kCJPopupAnimationDuration = 0.3;

static NSString *cjPopupAnimationTypeKey = @"cjPopupAnimationType";

@interface UIView () {
    
}
@property (nonatomic, copy) NSString *cjPopupViewHideFrameString;   /**< 弹出视图隐藏时候的frame */

@end



@implementation UIView (CJPopupFrameAnimation)

#pragma mark - runtime
//cjPopupAnimationType
- (CJAnimationType)cjPopupAnimationType {
    return [objc_getAssociatedObject(self, &cjPopupAnimationTypeKey) integerValue];
}

- (void)setCjPopupAnimationType:(CJAnimationType)cjPopupAnimationType {
    objc_setAssociatedObject(self, &cjPopupAnimationTypeKey, @(cjPopupAnimationType), OBJC_ASSOCIATION_ASSIGN);
}

/*
 *  弹出视图
 *
 *  @param popupViewShowFrame   popupViewShowFrame
 *  @param isToBottom           isToBottom
 *  @param animationType        animationType
 *  @param showComplete         showComplete
 */
- (void)cj_animateToShowFrame:(CGRect)popupViewShowFrame
                   isToBottom:(BOOL)isToBottom
                animationType:(CJAnimationType)animationType
                 showComplete:(void(^ _Nullable)(void))showComplete
{
    CGRect popupViewHideFrame = popupViewShowFrame;
    if (isToBottom) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow]; //
        popupViewHideFrame.origin.y = CGRectGetMaxY(keyWindow.frame);
    } else {
        popupViewHideFrame.size.height = 0;
    }
    
    
    self.cjPopupViewHideFrameString = NSStringFromCGRect(popupViewHideFrame);
    
    
    UIView *popupView = self;
    
//    if (popupSuperview.cjPopupSuperviewSubview == nil) {
//        popupSuperview.cjPopupSuperviewSubview = [[NSMutableArray alloc] init];
//    }
//    [popupSuperview.cjPopupSuperviewSubview addObject:blankView];
    
    
    
    if (animationType == CJAnimationTypeNone) {
        popupView.frame = popupViewShowFrame;
        
    } else if (animationType == CJAnimationTypeNormal) {
        //动画设置位置
//        UIView *blankView = self.cjTapView;
        UIView *blankView = self.superview;
        blankView.alpha = 0.2;
        popupView.alpha = 0.2;
        popupView.frame = popupViewHideFrame;
        [UIView animateWithDuration:kCJPopupAnimationDuration
                         animations:^{
                             blankView.alpha = 1.0;
                             popupView.alpha = 1.0;
                             popupView.frame = popupViewShowFrame;
                         }];
        
    } else if (animationType == CJAnimationTypeCATransform3D) {
        popupView.alpha = 1.0f; // 修复单例时候，在隐藏过后，想再显示，没法继续显示的问题
        popupView.frame = popupViewShowFrame;
        
        CATransform3D popupViewShowTransform = CATransform3DIdentity;
        
        CATransform3D rotate = CATransform3DMakeRotation(70.0*M_PI/180.0, 0.0, 0.0, 1.0);
        CATransform3D translate = CATransform3DMakeTranslation(20.0, -500.0, 0.0);
        CATransform3D popupViewHideTransform = CATransform3DConcat(rotate, translate);
        
        self.layer.transform = popupViewHideTransform;
        [UIView animateWithDuration:kCJPopupAnimationDuration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.layer.transform = popupViewShowTransform;
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }
    
    !showComplete ?: showComplete();
}

- (void)cj_hidePopupView {
    CJAnimationType animationType = self.cjPopupAnimationType;
    [self cj_hidePopupViewWithAnimationType:animationType];
}

- (void)cj_hidePopupViewWithAnimationType:(CJAnimationType)animationType {
//    CJPopupMainThreadAssert();
    
//    self.cjPopupViewShowing = NO;  //设置成NO表示当前未显示任何弹出视图
    [self endEditing:YES];
    
    UIView *popupView = self;
//    UIView *blankView = self.cjTapView;
    UIView *blankView = self.superview;
    
    switch (animationType) {
        case CJAnimationTypeNone:
        {
            [popupView removeFromSuperview];
            [blankView removeFromSuperview];
            break;
        }
        case CJAnimationTypeNormal:
        {
            CGRect popupViewHideFrame = CGRectFromString(self.cjPopupViewHideFrameString);
            if (CGRectEqualToRect(popupViewHideFrame, CGRectZero)) {
                popupViewHideFrame = self.frame;
            }
            
            [UIView animateWithDuration:kCJPopupAnimationDuration
                             animations:^{
                                 //要设置成0，不设置非零值如0.2，是为了防止在显示出来的时候，在0.3秒内很快按两次按钮，仍有view存在
                                 blankView.alpha = 0.0f;
                                 popupView.alpha = 0.0f;
                                 popupView.frame = popupViewHideFrame;
                                 
                             }completion:^(BOOL finished) {
                                 [popupView removeFromSuperview];
                                 [blankView removeFromSuperview];
                             }];
            break;
        }
        case CJAnimationTypeCATransform3D:
        {
            [UIView animateWithDuration:kCJPopupAnimationDuration
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 CATransform3D rotate = CATransform3DMakeRotation(-70.0 * M_PI / 180.0, 0.0, 0.0, 1.0);
                                 CATransform3D translate = CATransform3DMakeTranslation(-20.0, 500.0, 0.0);
                                 popupView.layer.transform = CATransform3DConcat(rotate, translate);
                                 
                             } completion:^(BOOL finished) {
                                 [popupView removeFromSuperview];
                                 [blankView removeFromSuperview];
                             }];
            break;
        }
    }
    
//    [self.cjPopupSuperviewSubview removeObject:blankView];
}



@end
