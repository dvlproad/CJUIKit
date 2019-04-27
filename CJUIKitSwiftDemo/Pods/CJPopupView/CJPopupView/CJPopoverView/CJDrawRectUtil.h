//
//  CJDrawRectUtil.h
//  CJPopupViewDemo
//
//  Created by ciyouzen on 6/24/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJArrowDirection) {
    CJArrowDirectionUp,
    CJArrowDirectionDown,
};


@interface CJDrawRectUtil : NSObject

#pragma mark - 箭头绘制
/**
 *  绘制带箭头的矩形
 *
 *  @param rect 在哪个区域内绘制
 *  @param arrowDirection   箭头的方向
 *  @param arrowPoint       箭头的尖点坐标
 *  @param arrowHeight      箭头的高度
 *  @param arrowCurvature   箭头的曲率/弯曲度
 *  @param arrowBorderColor 曲线上的颜色
 *  @param arrowFillColor   曲线内部的填充颜色（该颜色请务必与内部区域背景色一致，否则会有视觉颜色差）
 */
+ (void)drawArrowInRect:(CGRect)rect
     withArrowDirection:(CJArrowDirection)arrowDirection
             arrowPoint:(CGPoint)arrowPoint
            arrowHeight:(CGFloat)arrowHeight
         arrowCurvature:(CGFloat)arrowCurvature
       arrowBorderColor:(UIColor *)arrowBorderColor
         arrowFillColor:(UIColor *)arrowFillColor;

@end
