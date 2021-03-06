//
//  UIView+CJKeepBounds.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIView+CJKeepBounds.h"
#import "CGRectCJAdjustHelper.h"

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
    
    // 视图可移动的四边分别是
    CGFloat bondMinX = MAX(0, boundEdgeInsets.left); //黏合区域的minX
    CGFloat bondMaxX = MIN(originBondWidth, originBondWidth - boundEdgeInsets.right);   //黏合区域的maxX
    
    CGFloat bondMinY = MAX(0, boundEdgeInsets.top); //黏合区域的minY
    CGFloat bondMaxY = MIN(originBondHeight, originBondHeight - boundEdgeInsets.bottom); //黏合区域的maxY
    
    
    CGRect frame = self.frame;
    CGRect cageBound = CGRectMake(bondMinX, bondMinY, bondMaxX-bondMinX, bondMaxY-bondMinY);
    
    
    CGRect newSmallFrame = [CGRectCJAdjustHelper adjustXYForSmallFrame:frame
                                                  accordingToCageFrame:cageBound
                                         isKeepBoundsXYWhenBeyondBound:isKeepBoundsXYWhenBeyondBound
                                      isKeepBoundsXWhenContaintInBound:isKeepBoundsXWhenContaintInBound
                                      isKeepBoundsYWhenContaintInBound:isKeepBoundsYWhenContaintInBound];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"commonMove" context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    self.frame = newSmallFrame;
    [UIView commitAnimations];
}


@end
