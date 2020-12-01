//
//  UIView+CJToastInView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+CJToastInView.h"

@implementation UIView (CJToastInView)

/*
 *  将当前视图Toast到superView中央
 *
 *  @param superView                    显示到哪个视图中央
 *  @param size                         toast视图的大小
 *  @param centerOffset                 toast视图的中心与superView中心的偏移量
 *  @param animated                     弹出时候的动画采用的类型
 */
- (void)cj_toastCenterInView:(nullable UIView *)superView
                    withSize:(CGSize)size
                centerOffset:(CGPoint)centerOffset
                    animated:(BOOL)animated
{
    if (superView == nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    [superView addSubview:self];
    
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeCenterX   //centerX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:centerOffset.x]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeCenterY  //centerY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:centerOffset.y]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeWidth    //width
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:size.width]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:size.height]];
    
    [self __cj_toastUpdateAlpha:1 animated:animated completion:NULL];
}

/*
 *  隐藏弹出的toast视图
 *
 *  @param animated             是否要动画
 *  @param delay                多少秒后执行隐藏
 */
- (void)cj_toastHiddenWithAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self __cj_toastUpdateAlpha:0 animated:animated completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}


#pragma mark - Private Method
- (void)__cj_toastUpdateAlpha:(BOOL)alpha
                     animated:(BOOL)animated
                   completion:(void(^)(BOOL finished))completion
{
    if (animated == NO) {
        self.alpha = alpha;
        !completion ?: completion(YES);
        return;
    }
    
    // Perform animations
    dispatch_block_t animations = ^{
        self.transform = CGAffineTransformIdentity;
        
        self.alpha = alpha;
    };
    [UIView animateWithDuration:0.3
                          delay:0.
         usingSpringWithDamping:1.f
          initialSpringVelocity:0.f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:animations
                     completion:completion];
}


@end
