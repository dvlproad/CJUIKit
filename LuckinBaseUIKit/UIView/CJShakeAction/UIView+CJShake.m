//
//  UIView+CJShake.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+CJShake.h"
#import <objc/runtime.h>

static NSString * const cjShakeTypeKey = @"cjShakeTypeKey";

@implementation UIView (CJShake)

#pragma mark - runtime
//cjShakeType
- (CJShakeType)cjShakeType {
    return (CJShakeType)[objc_getAssociatedObject(self, &cjShakeTypeKey) integerValue];
}

- (void)setCjShakeType:(CJShakeType)cjShakeType {
    objc_setAssociatedObject(self, &cjShakeTypeKey, @(cjShakeType), OBJC_ASSOCIATION_ASSIGN);
}


/**
*  短暂抖动(常见于密码输入错误)
*/
- (void)cjShake
{
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setDuration:0.5f];
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [keyAn setValues:array];
    
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [keyAn setKeyTimes:times];
    
    [self.layer addAnimation:keyAn forKey:@"TextAnim"];
}


/**
 *  持续抖动(常见于拖动操作)
 */
- (void)cjShakeKeeping {
    
    CABasicAnimation *animation = (CABasicAnimation *)[self.layer animationForKey:@"rotation"];
    if (animation) {
        // 复原
        self.layer.speed = 1.0;
        return;
    }
    
    // 抖动动画
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setDuration:0.1];
    animation.fromValue = @(-M_1_PI/6);
    animation.toValue = @(M_1_PI/6);
    animation.repeatCount = HUGE_VAL;
    animation.autoreverses = YES;
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.layer addAnimation:animation forKey:@"rotation"];
    
}

@end
