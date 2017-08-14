//
//  ProcessLineView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/8/14.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ProcessLineView.h"

@implementation ProcessLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self drawEllipse];
    
    if (index < self.arrayRadius.count - 1) {
        
        UIView *radiuNext = [self.arrayRadius objectAtIndex:index + 1];
        
        //画 横线
        CGContextRef context = UIGraphicsGetCurrentContext();//获取当前ctx
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(ctx, .5);  //线宽
        CGContextSetAllowsAntialiasing(ctx, YES);
        CGContextSetRGBStrokeColor(context, 70.0 / 255.0, 241.0 / 255.0, 241.0 / 255.0, 1.0);  //线的颜色
        CGContextSetRGBStrokeColor(ctx, CricolColor_R, CricolColor_G, CricolColor_B, 1.0);  //颜色
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, radiu.center.x + Radiu_Width, radiu.center.y);  //起点坐标
        CGContextAddLineToPoint(ctx, radiuNext.center.x - Radiu_Width, radiuNext.center.y);   //终点坐标
        CGContextStrokePath(ctx);
        
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
///绘制
- (void)drawEllipse {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //边框圆
    CGContextSetRGBStrokeColor(context,1,1,1,1.0);  //画笔线的颜色
    CGContextSetLineWidth(context, 1.0);            //线的宽度
    
    CGFloat centerX = 30;
    CGFloat centerY = CGRectGetMidY(self.bounds);
    CGFloat radius = 15;
    CGContextAddArc(context, centerX, centerY, radius, 0, 2*M_PI, 0); //在视图中间添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
}

@end
