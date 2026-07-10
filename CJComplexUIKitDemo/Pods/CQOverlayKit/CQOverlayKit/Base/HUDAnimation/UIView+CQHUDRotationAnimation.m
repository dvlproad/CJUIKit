//
//  UIView+CQHUDRotationAnimation.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIView+CQHUDRotationAnimation.h"

@implementation UIView (CQHUDRotationAnimation)

- (void)cq_startOrContinueHUDRotationAnimation {
    CABasicAnimation *rotationAnimation = [self.layer animationForKey:@"cq_rotationAnimation"];
    if (rotationAnimation == nil) { // 如果当前视图还没有添加动画，则添加动画并运行
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
        rotationAnimation.toValue = [NSNumber numberWithFloat:6.0*M_PI];
        rotationAnimation.repeatCount = MAXFLOAT;
        rotationAnimation.duration = 4;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.layer addAnimation:rotationAnimation forKey:@"cq_rotationAnimation"];
        self.layer.speed = 1; // 修复有时候动画没转起来
    } else {                        // 如果当前视图已经添加动画，则运行添加的动画
        //让动画执行
        self.layer.speed = 1;

//        //获取上次动画停留的时刻
//        CFTimeInterval pauseTime = self.layer.timeOffset;
//
//        //取消上次记录的停留时刻
//        self.layer.timeOffset = 0;
//
//        //取消上次设置的时间
//        self.layer.beginTime = 0;
//
//        //计算暂停的时间，设置相对于父坐标系的开始时间
//        self.layer.beginTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    }
    
}

- (void)cq_stopHUDRotationAnimation {
    if (self.layer.speed > 0) { //如果此时的动画状态为执行状态
        // 将动画暂停
        self.layer.speed = 0;
        //将当前动画执行到的时间保存到layer的timeOffet中
        self.layer.timeOffset = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    }
}

@end
