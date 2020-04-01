//
//  UIView+CJAnimation.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/12.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+CJAnimation.h"

@implementation UIView (CJAnimation)

- (void)cj_commonTransitionFrom:(CJTransitionDirection)transitionDirection
              withAnimationType:(CJAnimateCommonType)animationType
{
    NSString *subtypeString = [self getsubtypeStringByTransitionDirection:transitionDirection];
    
    switch (animationType) {
        case CJAnimateCommonTypeFade:
            [self cj_transitionWithType:kCATransitionFade subtype:subtypeString];
            break;
            
        case CJAnimateCommonTypeMoveIn:
            [self cj_transitionWithType:kCATransitionMoveIn subtype:subtypeString];
            break;
            
        case CJAnimateCommonTypePush:
            [self cj_transitionWithType:kCATransitionPush subtype:subtypeString];
            break;
            
        case CJAnimateCommonTypeReveal:
            [self cj_transitionWithType:kCATransitionReveal subtype:subtypeString];
            break;
            
        default:
            break;
    }
}

- (void)cj_customTransitionFrom:(CJTransitionDirection)transitionDirection
              withAnimationType:(CJAnimateCustomType)animationType
{
    NSString *subtypeString = [self getsubtypeStringByTransitionDirection:transitionDirection];
    
    switch (animationType) {
        case CJAnimateCustomTypeCube:
            [self cj_transitionWithType:@"cube" subtype:subtypeString];
            break;
            
        case CJAnimateCustomTypeSuckEffect:
            [self cj_transitionWithType:@"suckEffect" subtype:subtypeString];
            break;
            
        case CJAnimateCustomTypeOglFlip:
            [self cj_transitionWithType:@"oglFlip" subtype:subtypeString];
            break;
            
        case CJAnimateCustomTypeRippleEffect:
            [self cj_transitionWithType:@"rippleEffect" subtype:subtypeString];
            break;
            
        case CJAnimateCustomTypePageCurl:
            [self cj_transitionWithType:@"pageCurl" subtype:subtypeString];
            break;
            
        case CJAnimateCustomTypePageUnCurl:
            [self cj_transitionWithType:@"pageUnCurl" subtype:subtypeString];
            break;
            
        case CJAnimateCustomTypeCameraIrisHollowOpen:
            [self cj_transitionWithType:@"cameraIrisHollowOpen" subtype:subtypeString];
            break;
            
        case CJAnimateCustomTypeCameraIrisHollowClose:
            [self cj_transitionWithType:@"cameraIrisHollowClose" subtype:subtypeString];
            break;
            
        default:
            break;
    }
}

- (NSString *)getsubtypeStringByTransitionDirection:(CJTransitionDirection)transitionDirection {
    NSString *subtypeString = nil;
    
    switch (transitionDirection) {
        case CJTransitionDirectionFromLeft:
            subtypeString = kCATransitionFromLeft;
            break;
        case CJTransitionDirectionFromBottom:
            subtypeString = kCATransitionFromBottom;
            break;
        case CJTransitionDirectionFromRight:
            subtypeString = kCATransitionFromRight;
            break;
        case CJTransitionDirectionFromTop:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    
    return subtypeString;
}



#pragma CATransition动画实现
- (void)cj_transitionWithType:(NSString *)type subtype:(NSString *)subtype
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.7;
    animation.type = type;
    
    if (subtype == nil) {
        subtype = kCATransitionFromRight;
    }
    animation.subtype = subtype; //设置子类
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //动画的时间节奏控制
    
    [self.layer addAnimation:animation forKey:@"animation"];
}



#pragma UIView实现动画
/* 完整的描述请参见文件头部 */
- (void)cj_animationWithAnimationTransition:(UIViewAnimationTransition)transition
{
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:self cache:YES];
    }];
}

@end
