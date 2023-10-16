//
//  PopupViewFrameCJHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "PopupViewFrameCJHelper.h"

@implementation PopupViewFrameCJHelper

/*
 *  将当前视图弹出到视图view底部
 *
 *  @param popupSuperview               弹出视图的父视图view(可以为nil,为nil时候弹出到keyWindow上)
 *  @param popupViewHeight              弹出视图的高度
 *  @param edgeInsets                   弹窗与window的(左右下)边距
 */
+ (CGRect)popupViewShowFrame_inBottomInView:(nullable UIView *)popupSuperview
                                 withHeight:(CGFloat)popupViewHeight
                                 edgeInsets:(UIEdgeInsets)edgeInsets
{
    NSAssert(popupViewHeight != 0, @"底部弹出视图的高度不能为0");
    if (popupSuperview == nil) {
        popupSuperview = [[UIApplication sharedApplication] keyWindow];
    }
    
    CGFloat popupViewWidth = CGRectGetWidth(popupSuperview.frame) - edgeInsets.left - edgeInsets.right;
    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    
    CGFloat popupViewX = edgeInsets.left;
    CGFloat popupViewShowY = CGRectGetHeight(popupSuperview.frame) - popupViewHeight - edgeInsets.bottom;
    CGPoint popupViewOrigin = CGPointMake(popupViewX, popupViewShowY);
    
    CGRect popupViewShowFrame = CGRectMake(popupViewOrigin.x, popupViewOrigin.y,
                                           popupViewSize.width, popupViewSize.height);
    return popupViewShowFrame;
}

/*
 *  获取popupSuperview里的指定frame
 *
 *  @param popupSuperview               弹出视图的父视图view(可以为nil,为nil时候弹出到keyWindow上)
 *  @param popupViewSize                弹出视图的大小
 *  @param centerOffset                 弹窗弹出位置的中心与window中心的偏移量
 */
+ (CGRect)popupViewShowFrame_InCenterInView:(nullable UIView *)popupSuperview
                                   withSize:(CGSize)popupViewSize
                               centerOffset:(CGPoint)centerOffset
{
    CGFloat popupSuperviewWidth = CGRectGetWidth(popupSuperview.frame);
    CGFloat popupSuperviewHeight = CGRectGetHeight(popupSuperview.frame);
    NSAssert(popupSuperviewWidth != 0 && popupSuperviewHeight != 0, @"弹出视图的父视图宽高都不能为0，否则无法计算内部视图位置");
    
    CGPoint popupViewShowCenter = CGPointMake(popupSuperviewWidth/2 + centerOffset.x,
                                              popupSuperviewHeight/2 + centerOffset.y);
    NSAssert(popupViewSize.width != 0 && popupViewSize.height != 0, @"弹出视图的宽高都不能为0");
    CGFloat originX = popupViewShowCenter.x - popupViewSize.width/2;
    CGFloat originY = popupViewShowCenter.y - popupViewSize.height/2;
    CGPoint popupViewOrigin = CGPointMake(originX, originY);
    
    
    // popupView改成添加到blankView中
    CGRect popupViewShowFrame = CGRectMake(popupViewOrigin.x, popupViewOrigin.y,
                                           popupViewSize.width, popupViewSize.height);
    return popupViewShowFrame;
}


@end
