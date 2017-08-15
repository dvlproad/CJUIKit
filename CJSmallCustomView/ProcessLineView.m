//
//  ProcessLineView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2014/8/14.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import "ProcessLineView.h"

@implementation ProcessLineView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //让整个区域白色
//    [[UIColor whiteColor] set];
//    CGContextFillRect(context, rect);
    
    
    CGPoint centerOfCirclePoint = CGPointMake(20, CGRectGetMidY(self.bounds)); //圆心
    
    CGFloat lastRadius = 0;
    if (self.processLineViewType == ProcessLineViewTypeDoing) {
        //画外层填充圆
        CGFloat radius = 7; //半径
        CGRect circleFrame = CGRectMake(centerOfCirclePoint.x-radius, centerOfCirclePoint.y-radius, 2*radius, 2*radius);
        CGContextAddEllipseInRect(context, circleFrame);
        [[UIColor colorWithRed:206/255.0 green:227/255.0 blue:255/255.0 alpha:1] set]; //#cee3ff 淡蓝色
        CGContextFillPath(context);
        
        
        //画内层填充圆
        CGFloat smallRadius = 3; //半径
        CGRect samllCircleFrame = CGRectMake(centerOfCirclePoint.x-smallRadius, centerOfCirclePoint.y-smallRadius, 2*smallRadius, 2*smallRadius);
        CGContextAddEllipseInRect(context, samllCircleFrame);
        [[UIColor colorWithRed:51/255.0 green:137/255.0 blue:255/255.0 alpha:1] set];
        CGContextFillPath(context);
        
        lastRadius = radius;
        
    } else if (self.processLineViewType == ProcessLineViewTypeDone) {
        //画内层填充圆
        CGFloat smallRadius = 4; //半径
        CGRect samllCircleFrame = CGRectMake(centerOfCirclePoint.x-smallRadius, centerOfCirclePoint.y-smallRadius, 2*smallRadius, 2*smallRadius);
        CGContextAddEllipseInRect(context, samllCircleFrame);
        [[UIColor colorWithRed:51/255.0 green:137/255.0 blue:255/255.0 alpha:1] set];
        CGContextFillPath(context);
        
        lastRadius = smallRadius;
    } else {
        //画内层填充圆
        CGFloat smallRadius = 4; //半径
        CGRect samllCircleFrame = CGRectMake(centerOfCirclePoint.x-smallRadius, centerOfCirclePoint.y-smallRadius, 2*smallRadius, 2*smallRadius);
        CGContextAddEllipseInRect(context, samllCircleFrame);
        [[UIColor lightGrayColor] set];
        CGContextFillPath(context);
        
        lastRadius = smallRadius;
    }
    
    
    //边框圆
//    CGContextSetRGBStrokeColor(context, 206/255.0, 227/255.0, 255/255.0, 1);  //线的颜色#cee3ff
//    CGContextSetRGBStrokeColor(context, 51/255.0, 137/255.0, 255/255.0, 1);  //线的颜色#3389ff
//    CGContextSetLineWidth(context, 1.0);            //线的宽度
//    CGContextAddArc(context, centerOfCirclePoint.x, centerOfCirclePoint.y, radius, 0, 2*M_PI, 0); //在视图中间添加一个圆
//    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    //画线
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetRGBStrokeColor(context, 51/255.0, 137/255.0, 255/255.0, 1);  //线的颜色#3389ff
    
    if (self.processLineViewIndexType == ProcessLineViewIndexTypeOther) {
        //画圆圈的上部分
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, centerOfCirclePoint.x, 0);  //起点坐标
        CGContextAddLineToPoint(context, centerOfCirclePoint.x, centerOfCirclePoint.y-lastRadius);   //终点坐标
        CGContextStrokePath(context);
        
        //画圆圈的下部分
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, centerOfCirclePoint.x, centerOfCirclePoint.y+lastRadius);
        CGContextAddLineToPoint(context, centerOfCirclePoint.x, CGRectGetMaxY(self.bounds));
        CGContextStrokePath(context);
        
    } else if (self.processLineViewIndexType == ProcessLineViewIndexTypeStart) {
        //画圆圈的下部分
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, centerOfCirclePoint.x, centerOfCirclePoint.y+lastRadius);        CGContextAddLineToPoint(context, centerOfCirclePoint.x, CGRectGetMaxY(self.bounds));
        CGContextStrokePath(context);
    } else {
        //画圆圈的上部分
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, centerOfCirclePoint.x, 0);
        CGContextAddLineToPoint(context, centerOfCirclePoint.x, centerOfCirclePoint.y-lastRadius);
        CGContextStrokePath(context);
    }
}



/*
 //画圆的方法
 CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, // 圆心坐标(x,y)
 CGFloat radius, // 半径
 CGFloat startAngle, CGFloat endAngle, // 开始、结束弧度
 int clockwise // 绘制方向，clockwise 0为顺时针，1为逆时针
 )
 */

@end
