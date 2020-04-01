//
//  UIView+CJAnimation.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/12.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  其他:[iOS 画面切换的各种动画效果附私有API](https://yq.aliyun.com/ziliao/66035)

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJAnimateCommonType) {
    CJAnimateCommonTypeFade = 0,                   //淡入淡出
    CJAnimateCommonTypeMoveIn,                     //覆盖
    CJAnimateCommonTypePush,                       //推挤
    CJAnimateCommonTypeReveal,                     //揭开
};

typedef NS_ENUM(NSUInteger, CJAnimateCustomType) {
    CJAnimateCustomTypeCube,                       //立方体
    CJAnimateCustomTypeSuckEffect,                 //吮吸
    CJAnimateCustomTypeOglFlip,                    //翻转
    CJAnimateCustomTypeRippleEffect,               //波纹
    CJAnimateCustomTypePageCurl,                   //翻页
    CJAnimateCustomTypePageUnCurl,                 //反翻页
    CJAnimateCustomTypeCameraIrisHollowOpen,       //开镜头
    CJAnimateCustomTypeCameraIrisHollowClose,      //关镜头
};

typedef NS_ENUM(NSUInteger, CJTransitionDirection) {
    CJTransitionDirectionFromTop = 0,
    CJTransitionDirectionFromLeft,
    CJTransitionDirectionFromBottom,
    CJTransitionDirectionFromRight,
};


/**
 *  执行动画
 */
@interface UIView (CJAnimation)

///执行(Fade淡入淡出、MoveIn覆盖、Push推挤、Reveal揭开)动画
- (void)cj_commonTransitionFrom:(CJTransitionDirection)transitionDirection
              withAnimationType:(CJAnimateCommonType)animationType;

- (void)cj_customTransitionFrom:(CJTransitionDirection)transitionDirection
              withAnimationType:(CJAnimateCustomType)animationType;

///支持(None无、FlipFromLeft左翻转、FlipFromRight右翻转、CurlUp上翻页、CurlDown下翻页)动画
- (void)cj_animationWithAnimationTransition:(UIViewAnimationTransition)transition;

@end
