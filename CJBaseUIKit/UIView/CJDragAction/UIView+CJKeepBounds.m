//
//  UIView+CJKeepBounds.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIView+CJKeepBounds.h"

@implementation UIView (CJKeepBounds)

/*
 *  黏合区域(①当视图超出边界的时候，XY是否黏合最近边界;②当视图没超出边界的时候，X也会黏合最近边界)
 */
- (void)cjKeepBounds {
    [self cjKeepBoundsWithBoundEdgeInsets:UIEdgeInsetsZero
            isKeepBoundsXYWhenBeyondBound:YES
         isKeepBoundsXWhenContaintInBound:YES
         isKeepBoundsYWhenContaintInBound:NO];
}

/*
 *  黏合区域（吸附时候：如果是view最大到其父视图的范围，如果是window最大到keyWindow）
 *
 *  @param boundEdgeInsets                  黏合区域（黏合时候与边界的边距，上下边界可以完全黏合的时候是UIEdgeInsetsZero）
 *  @param isKeepBoundsXYWhenBeyondBound    当视图超出边界的时候，XY是否黏合最近边界
 *  @param isKeepBoundsXWhenContaintInBound 当视图没超出边界的时候，X是否黏合最近边界
 *  @param isKeepBoundsYWhenContaintInBound 当视图没超出边界的时候，Y是否黏合最近边界
 */
- (void)cjKeepBoundsWithBoundEdgeInsets:(UIEdgeInsets)boundEdgeInsets
          isKeepBoundsXYWhenBeyondBound:(BOOL)isKeepBoundsXYWhenBeyondBound
       isKeepBoundsXWhenContaintInBound:(BOOL)isKeepBoundsXWhenContaintInBound
       isKeepBoundsYWhenContaintInBound:(BOOL)isKeepBoundsYWhenContaintInBound
{
    CGFloat originBondWidth = 0;    //原本宽的拖动限制范围(0到此值)
    CGFloat originBondHeight = 0;   //原本高的拖动限制范围(0到此值)
    if ([self isKindOfClass:[UIWindow class]]) {
        originBondWidth = CGRectGetWidth([[UIApplication sharedApplication] keyWindow].frame);
        originBondHeight = CGRectGetHeight([[UIApplication sharedApplication] keyWindow].frame);
        
    } else {
        NSAssert(self.superview != nil, @"请先将当前视图添加到视图上，再执行此方法");
        originBondWidth = CGRectGetWidth(self.superview.frame);
        originBondHeight = CGRectGetHeight(self.superview.frame);
    }
    
    
    CGFloat bondMinX = MAX(0, boundEdgeInsets.left); //黏合区域的minX
    CGFloat bondMaxX = MIN(originBondWidth, originBondWidth - boundEdgeInsets.right);   //黏合区域的maxX
    
    //1、x的黏合：先判断是否超出边界，如果超出边界，是否自动黏合
    if (CGRectGetMinX(self.frame) < bondMinX) {
        if (isKeepBoundsXYWhenBeyondBound) {    //超出左边界，自动黏合到左侧
            [self absorbXToLeftMinX:bondMinX];
        }
        
    } else if(CGRectGetMaxX(self.frame) > bondMaxX) {
        if (isKeepBoundsXYWhenBeyondBound) {    //超出右边界，自动黏合到右侧
            [self absorbXToRightMaxX:bondMaxX];
        }
    } else if (CGRectGetMidX(self.frame) < bondMinX + (bondMaxX-bondMinX)/2) {
        if (isKeepBoundsXWhenContaintInBound) { //在左边界及中间边界之间，自动黏合到左侧
            [self absorbXToLeftMinX:bondMinX];
        }
        
    } else {
        if (isKeepBoundsXWhenContaintInBound) { //在中间边界及右边界之间，自动黏合到右侧
            [self absorbXToRightMaxX:bondMaxX];
        }
    }
    
    
    CGFloat bondMinY = MAX(0, boundEdgeInsets.top); //黏合区域的minY
    CGFloat bondMaxY = MIN(originBondHeight, originBondHeight - boundEdgeInsets.bottom); //黏合区域的maxY
    //2、y的黏合：只需考虑超出边界是否黏合，不超出边界的话，不用处理y
    if (CGRectGetMinY(self.frame) < bondMinY) {
        if (isKeepBoundsXYWhenBeyondBound) {    //超出上边界，自动黏合到上侧
            [self absorbYToTopMinY:bondMinY];
        }
        
    } else if(CGRectGetMaxY(self.frame) > bondMaxY){
        if (isKeepBoundsXYWhenBeyondBound) {    //超出下边界，自动黏合到下侧
            [self absorbYToBottomMaxY:bondMaxY];
        }
    } else if (CGRectGetMidY(self.frame) < bondMinY + (bondMaxY-bondMinY)/2) {
        if (isKeepBoundsYWhenContaintInBound) { //在上边界及中间边界之间，自动黏合到上侧
            [self absorbYToTopMinY:bondMinY];
        }
        
    } else {
        if (isKeepBoundsYWhenContaintInBound) { //在中间边界及下边界之间，自动黏合到下侧
            [self absorbYToBottomMaxY:bondMaxY];
        }
    }
}

#pragma mark - 吸附方法
- (void)absorbXToLeftMinX:(CGFloat)bondMinX {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"leftMove" context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = self.frame;
    frame.origin.x = bondMinX;
    self.frame = frame;
    [UIView commitAnimations];
}

- (void)absorbXToRightMaxX:(CGFloat)bondMaxX {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"rightMove" context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = self.frame;
    frame.origin.x = bondMaxX - CGRectGetWidth(self.frame);
    self.frame = frame;
    [UIView commitAnimations];
}


- (void)absorbYToTopMinY:(CGFloat)bondMinY {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"topMove" context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = self.frame;
    frame.origin.y = bondMinY;
    self.frame = frame;
    [UIView commitAnimations];
}

- (void)absorbYToBottomMaxY:(CGFloat)bondMaxY {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"bottomMove" context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = self.frame;
    frame.origin.y = bondMaxY - CGRectGetHeight(self.frame);
    self.frame = frame;
    [UIView commitAnimations];
}

@end
