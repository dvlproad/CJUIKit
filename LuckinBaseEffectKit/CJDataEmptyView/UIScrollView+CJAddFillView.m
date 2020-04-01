//
//  UIScrollView+CJAddFillView.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2018/2/6.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIScrollView+CJAddFillView.h"
#import <objc/runtime.h>

@interface UIScrollView () {
    
}

@end


@implementation UIScrollView (CJAddFillView)

/// 添加占满UIScrollView的视图(会同时更新ScrollView的ContentSize)
- (void)cj_addFillView:(UIView *)fillView {
    [self addSubview:fillView];
    fillView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:fillView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:fillView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:fillView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:fillView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    
    [self cj_setupContentSizeByView:fillView exceptBottomFromView:nil heighExceedValue:1];
}

/**
 *  set or update ScrollView ContentSize with fillView
 *
 *  @param sizeFromView     the contentSize width value from it
 *  @param bottomFromView   the contentSize height value from it.(if nil, the contentSize height will from sizeFromView)
 *  @param heighExceedValue the contentSize height more than bottomFromView(when bottomFromView is nil, mean more than sizeFromView)
 */
- (void)cj_setupContentSizeByView:(UIView *)sizeFromView
             exceptBottomFromView:(nullable UIView *)bottomFromView
                 heighExceedValue:(CGFloat)heighExceedValue
{
    NSAssert(heighExceedValue >= 0, @"Error:scrollView与lastBottomView的底部间隔不能小于0");
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:sizeFromView
                                  attribute:NSLayoutAttributeWidth //width
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1
                                   constant:0]];
    
    if (bottomFromView == nil) {
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:sizeFromView
                                      attribute:NSLayoutAttributeHeight //height
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeHeight
                                     multiplier:1
                                       constant:heighExceedValue]];
    } else {
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:sizeFromView
                                      attribute:NSLayoutAttributeBottom //bottom
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:bottomFromView
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                       constant:heighExceedValue]];
    }
}

@end
