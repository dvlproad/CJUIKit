//
//  UIView+CJKeepBounds.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/05.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIView+CJKeepBounds.h"

@implementation UIView (CJKeepBounds)

/* 完整的描述请参见文件头部 */
- (void)cjKeepBounds {
    [self cjKeepBoundsWithBoundEdgeInsets:UIEdgeInsetsZero
            isKeepBoundsXYWhenBeyondBound:YES
         isKeepBoundsXWhenContaintInBound:NO];
}

/* 完整的描述请参见文件头部 */
- (void)cjKeepBoundsWithBoundEdgeInsets:(UIEdgeInsets)boundEdgeInsets
          isKeepBoundsXYWhenBeyondBound:(BOOL)isKeepBoundsXYWhenBeyondBound
       isKeepBoundsXWhenContaintInBound:(BOOL)isKeepBoundsXWhenContaintInBound
{
    NSAssert(self.superview != nil, @"请先将当前视图添加到视图上，再执行此方法");
    
    CGFloat bondMinX = MAX(0, boundEdgeInsets.left); //黏合区域的minX
    CGFloat bondMaxX = MIN(CGRectGetWidth(self.superview.frame), CGRectGetWidth(self.superview.frame) - boundEdgeInsets.right);   //黏合区域的maxX
    
    //1、x的黏合：先判断是否超出边界，如果超出边界，是否自动黏合
    if (CGRectGetMinX(self.frame) < bondMinX)
    {
        if (isKeepBoundsXYWhenBeyondBound) { //超出边界，自动黏合
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"leftMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            
            CGRect frame = self.frame;
            frame.origin.x = bondMinX;
            self.frame = frame;
            [UIView commitAnimations];
        }
        
    } else if(CGRectGetMaxX(self.frame) > bondMaxX) {
        if (isKeepBoundsXYWhenBeyondBound) { //超出边界，自动黏合
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"rightMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            
            CGRect frame = self.frame;
            frame.origin.x = bondMaxX - CGRectGetWidth(self.frame);
            self.frame = frame;
            [UIView commitAnimations];
        }
    } else if (CGRectGetMidX(self.frame) < bondMinX + (bondMaxX-bondMinX)/2) {
        if (1) { //没超出边界的话，自动黏合
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"leftMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            
            CGRect frame = self.frame;
            frame.origin.x = bondMinX;
            self.frame = frame;
            [UIView commitAnimations];
        }
        
    } else {
        if (1) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"rightMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            
            CGRect frame = self.frame;
            frame.origin.x = bondMaxX - CGRectGetWidth(self.frame);
            self.frame = frame;
            [UIView commitAnimations];
        }
    }
    
    
    CGFloat bondMinY = MAX(0, boundEdgeInsets.top); //黏合区域的minY
    CGFloat bondMaxY = MIN(CGRectGetHeight(self.superview.frame), CGRectGetHeight(self.superview.frame) - boundEdgeInsets.bottom); //黏合区域的maxY
    //2、y的黏合：只需考虑超出边界是否黏合，不超出边界的话，不用处理y
    if (CGRectGetMinY(self.frame) < bondMinY) {
        if (isKeepBoundsXYWhenBeyondBound) { //超出边界，自动黏合
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"topMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            
            CGRect frame = self.frame;
            frame.origin.y = bondMinY;
            self.frame = frame;
            [UIView commitAnimations];
        }
        
    } else if(CGRectGetMaxY(self.frame) > bondMaxY){
        if (isKeepBoundsXYWhenBeyondBound) { //超出边界，自动黏合
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"bottomMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            
            CGRect frame = self.frame;
            frame.origin.y = bondMaxY - CGRectGetHeight(self.frame);
            self.frame = frame;
            [UIView commitAnimations];
        }
    }
}

@end
