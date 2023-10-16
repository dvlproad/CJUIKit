//
//  CQEffectAndCornerHelper.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQEffectAndCornerHelper.h"
#import "CQEffectViewFactory.h"

@implementation CQEffectAndCornerHelper

#pragma mark - 基础方法
#pragma mark 基础方法：模糊化
/*
 *  对弹出视图进行【模糊指定区域】
 *  ps:如果模糊化操作有新视图生成，则再当要圆角化的子视图还等于模糊化的子视图时候，也要为此新模糊视图添加corner
 *
 *  @param effectStyle                      创建生成【指定类型】的模糊视图
 *  @param newEffectViewAddToView           将生成的模糊视图添加到【指定的视图】上，作为该视图的背景层/第一层
 *  @param newEffectViewCloseToViewSubView  将添加的模糊视图依靠在【视图】的【指定区域】上(可能为整个区域或某个子视图区域)
 *
 *  @return 返回执行此操作后，额外添加上去的视图(可能为nil)
 */
+ (nullable UIVisualEffectView *)createEffectViewWithEffectStyle:(CQEffectStyle)effectStyle
                                          newEffectViewAddToView:(UIView *)newEffectViewAddToView
                                 newEffectViewCloseToViewSubView:(UIView *)newEffectViewCloseToViewSubView
{
    if (effectStyle == CQEffectStyleNone) {
        return nil;
    }
    
    BOOL isChildView =  [newEffectViewCloseToViewSubView isDescendantOfView:newEffectViewAddToView];
    
    UIVisualEffectView *effectView = nil;
    if (effectStyle == CQEffectStyleBGColor) {
        UIColor *blankBGColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:.8];
        newEffectViewAddToView.backgroundColor = blankBGColor;
        
    } else if (effectStyle == CQEffectStyleBlurLight) {
        effectView = [CQEffectViewFactory addEffectWithStyle:UIBlurEffectStyleLight
                                                 backForView:newEffectViewAddToView
                                                 closeToView:newEffectViewCloseToViewSubView];
        
    } else if (effectStyle == CQEffectStyleBlurDark) {
        effectView = [CQEffectViewFactory addEffectWithStyle:UIBlurEffectStyleDark
                                                 backForView:newEffectViewAddToView
                                                 closeToView:newEffectViewCloseToViewSubView];
        
    }
    return effectView;
}


#pragma mark 基础方法：圆角化
/*
 *  为【指定的视图(支持UIScrollView)】设置mask实现圆角的
 *  ps:请在layoutSubviews中使用
 *
 *  @param cornerToSubView  要设置mask实现圆角的视图
 *  @param cornerRadius     圆角的角度
 */
+ (void)cornerByMaskToView:(UIView *)cornerToSubView
          withCornerRadius:(CGFloat)cornerRadius
{
    if (CGRectGetWidth(cornerToSubView.frame) == 0 || CGRectGetHeight(cornerToSubView.frame)) {
        NSLog(@"警告⚠️⚠️⚠️⚠️⚠️：实现圆角失败。\
              原因：此视图的宽或高为0了。无法获取到曲线bezierPathWithRoundedRect:的参数，所以请\
              方法①在视图的layoutSubviews中使用此方法，\
              方法②计算并设置进cornerToSubView的精确frame后再使用此方法");
        return;
    }
    
    CGRect borderRect = CGRectZero;
    if ([cornerToSubView isKindOfClass:[UIScrollView class]]) {
#ifdef DEBUG
        NSLog(@"---设置mask实现圆角的提示1：此要通过设置mask来实现圆角的视图%@是滚动列表。所以需要去取视图的contentSize的高度作为bezierPathWithRoundedRect。否则如果设置成bounds，则超出bounds的contentSize部分会由于设置了mask导致在滑动的时候被遮罩住没法显示了。", NSStringFromClass([cornerToSubView class]));
#endif
        CGSize contentSize = ((UIScrollView *)cornerToSubView).contentSize;
        if (CGSizeEqualToSize(cornerToSubView.bounds.size, CGSizeZero) == NO &&
            CGSizeEqualToSize(contentSize, CGSizeZero) == YES) {
#ifdef DEBUG
            NSLog(@"---设置mask实现圆角的提示2：此要通过设置mask来实现圆角的滚动视图的boundsSize不为0,但contentSize为0。原因是如集合视图内部还没绘制。所以我们主动调用[xxx.superview layoutIfNeeded];来让其绘制,然后再重新获取一遍contentSize");
#endif
            [cornerToSubView layoutIfNeeded];
            contentSize = ((UIScrollView *)cornerToSubView).contentSize;
        }
        borderRect = CGRectMake(0, 0, contentSize.width, contentSize.height);
    } else {
        borderRect = cornerToSubView.bounds;
    }
    NSAssert(CGRectGetWidth(borderRect) != 0 && CGRectGetHeight(borderRect) != 0, @"宽高都不能为0");
    
    // 添加mask实现圆角的代码
    UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:borderRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
    fieldLayer.frame = borderRect;
    fieldLayer.path = fieldPath.CGPath;
    cornerToSubView.layer.mask = fieldLayer;
}

@end
