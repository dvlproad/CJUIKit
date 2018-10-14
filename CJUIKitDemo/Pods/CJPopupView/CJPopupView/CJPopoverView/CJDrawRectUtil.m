//
//  CJDrawRectUtil.m
//  CJPopupViewDemo
//
//  Created by ciyouzen on 6/24/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJDrawRectUtil.h"

@implementation CJDrawRectUtil

/* 完整的描述请参见文件头部 */
+ (void)drawArrowInRect:(CGRect)rect
     withArrowDirection:(CJArrowDirection)arrowDirection
             arrowPoint:(CGPoint)arrowPoint
            arrowHeight:(CGFloat)arrowHeight
         arrowCurvature:(CGFloat)arrowCurvature
       arrowBorderColor:(UIColor *)arrowBorderColor
         arrowFillColor:(UIColor *)arrowFillColor
{
    /*
     *
     * *
     ****   ****
     *         *
     *         *
     *         *
     *         *
     *         *
     *         *
     ***********
     */
    
    [arrowBorderColor set]; //设置线条颜色
    
    
    UIBezierPath *popoverPath = [UIBezierPath bezierPath];
    if (arrowDirection == CJArrowDirectionUp) {
        CGRect frame = CGRectMake(0, 10, rect.size.width, rect.size.height - arrowHeight);
        
        float xMin = CGRectGetMinX(frame);
        float yMin = CGRectGetMinY(frame);
        
        float xMax = CGRectGetMaxX(frame);
        float yMax = CGRectGetMaxY(frame);
        
        
        [popoverPath moveToPoint:CGPointMake(xMin, yMin)];//左上角
        
        /********************向上的箭头**********************/
        [popoverPath addLineToPoint:CGPointMake(arrowPoint.x - arrowHeight, yMin)];//left side
        [popoverPath addCurveToPoint:arrowPoint
                       controlPoint1:CGPointMake(arrowPoint.x - arrowHeight + arrowCurvature, yMin)
                       controlPoint2:arrowPoint];//actual arrow point
        
        [popoverPath addCurveToPoint:CGPointMake(arrowPoint.x + arrowHeight, yMin)
                       controlPoint1:arrowPoint
                       controlPoint2:CGPointMake(arrowPoint.x + arrowHeight - arrowCurvature, yMin)];//right side
        /********************向上的箭头**********************/
        
        
        [popoverPath addLineToPoint:CGPointMake(xMax, yMin)];//右上角
        
        [popoverPath addLineToPoint:CGPointMake(xMax, yMax)];//右下角
        
        [popoverPath addLineToPoint:CGPointMake(xMin, yMax)];//左下角
        
    } else {
        CGRect frame = CGRectMake(0, 0, rect.size.width, rect.size.height - arrowHeight);
        
        float xMin = CGRectGetMinX(frame);
        float yMin = CGRectGetMinY(frame);
        
        float xMax = CGRectGetMaxX(frame);
        float yMax = CGRectGetMaxY(frame);
        
        
        [popoverPath moveToPoint:CGPointMake(xMin, yMax)];//左下角
        
        /********************向上的箭头**********************/
        [popoverPath addLineToPoint:CGPointMake(arrowPoint.x - arrowHeight, yMax)];//left side
        
        [popoverPath addCurveToPoint:arrowPoint
                       controlPoint1:CGPointMake(arrowPoint.x - arrowHeight + arrowCurvature, yMax)
                       controlPoint2:arrowPoint];//actual arrow point
        
        [popoverPath addCurveToPoint:CGPointMake(arrowPoint.x + arrowHeight, yMax)
                       controlPoint1:arrowPoint
                       controlPoint2:CGPointMake(arrowPoint.x + arrowHeight - arrowCurvature, yMax)];//right side
        /********************向上的箭头**********************/
        
        
        [popoverPath addLineToPoint:CGPointMake(xMax, yMax)];//右上角
        
        [popoverPath addLineToPoint:CGPointMake(xMax, yMin)];//右下角
        
        [popoverPath addLineToPoint:CGPointMake(xMin, yMin)];//左下角
        
        
    }
    
    //填充颜色
    [arrowFillColor setFill];
    [popoverPath fill];
    
    [popoverPath closePath];
    [popoverPath stroke];
    
}

@end
