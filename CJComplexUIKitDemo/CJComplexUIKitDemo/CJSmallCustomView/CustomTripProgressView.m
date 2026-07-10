//
//  CustomTripProgressView.m
//  TXLaoXiang
//
//  Created by WolfCub on 15/11/24.
//  Copyright © 2015年 WolfCub. All rights reserved.
//

#import "CustomTripProgressView.h"

#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)

#define SelectColor [UIColor colorWithRed:14/255.0 green:197/255.0 blue:96/255.0 alpha:1.0]
#define NormallColor [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0]

#define LineColor_R .3
#define LineColor_G .2
#define LineColor_B .2

#define CricolColor_R .33
#define CricolColor_G .33
#define CricolColor_B .33

#define Radiu_Width 12

#define PI 3.14159265358979323846

@implementation CustomTripProgressView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int index = 0; index < self.arrayRadius.count; index ++) {
        
        UIView *radiu = [self.arrayRadius objectAtIndex:index];
        
        //边框圆
        CGContextSetRGBStrokeColor(context,CricolColor_R,CricolColor_G,CricolColor_B,1.0);//画笔线的颜色
        CGContextSetLineWidth(context, 1.0);//线的宽度
        CGContextAddArc(context, radiu.center.x, radiu.center.y, Radiu_Width/2, 0, 2*PI, 0);//画圆圈
        CGContextDrawPath(context, kCGPathStroke); //绘制路径
        
        if (index < self.arrayRadius.count - 1) {
            
            UIView *radiuNext = [self.arrayRadius objectAtIndex:index + 1];
            
            //画 横线
            CGContextRef ctx = UIGraphicsGetCurrentContext();//获取当前ctx
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(ctx, .5);  //线宽
            CGContextSetAllowsAntialiasing(ctx, YES);
            CGContextSetRGBStrokeColor(ctx, CricolColor_R, CricolColor_G, CricolColor_B, 1.0);  //颜色
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, radiu.center.x + Radiu_Width, radiu.center.y);  //起点坐标
            CGContextAddLineToPoint(ctx, radiuNext.center.x - Radiu_Width, radiuNext.center.y);   //终点坐标
            CGContextStrokePath(ctx);
            
        }
    }
    
    
}


-(id)initWithFrame:(CGRect)frame andTitles:(NSArray*)someTitles {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        myFrame = frame;
        
        if (someTitles.count) {
            
            titles = [NSArray arrayWithArray:someTitles];
            
            self.arrayLabels = [NSMutableArray arrayWithCapacity:2];
            self.arrayRadius = [NSMutableArray arrayWithCapacity:2];
            
            for (int index = 0; index < titles.count; index ++) {
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(index * (myFrame.size.width/titles.count), myFrame.size.height - 20, myFrame.size.width/titles.count, 20)];
                
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = 1;
                [label setText:[titles objectAtIndex:index]];
                label.font = [UIFont systemFontOfSize:14];
                [label setTextColor:NormallColor];
                
                [self addSubview:label];
                [self.arrayLabels addObject:label];
                
                CGPoint center = CGPointMake(label.frame.origin.x + label.frame.size.width/2, (myFrame.size.height - 20)/2);
                
                UIView *radiu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Radiu_Width + 1, Radiu_Width + 1)];
                radiu.center = center;
                radiu.backgroundColor = SelectColor;
                radiu.layer.cornerRadius = (Radiu_Width + 1)/2;
                radiu.hidden = YES;
                [self addSubview:radiu];
                
                [self.arrayRadius addObject:radiu];
            }
            
        }
        
        
    }
    
    return self;
}

-(void)setSelectIndex:(NSInteger)index {
    
    if (index >= 0 && index < self.arrayLabels.count) {
        
        ((UILabel*)[self.arrayLabels objectAtIndex:index]).textColor = SelectColor;
        
        ((UIView*)[self.arrayRadius objectAtIndex:index]).hidden = NO;
    }
}

@end
