//
//  PopupViewFrameCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopupViewFrameCJHelper : NSObject

/*
 *  将当前视图弹出到视图view底部
 *
 *  @param popupSuperview               弹出视图的父视图view(可以为nil,为nil时候弹出到keyWindow上)
 *  @param popupViewHeight              弹出视图的高度
 *  @param edgeInsets                   弹窗与window的(左右下)边距
 */
+ (CGRect)popupViewShowFrame_inBottomInView:(nullable UIView *)popupSuperview
                                 withHeight:(CGFloat)popupViewHeight
                                 edgeInsets:(UIEdgeInsets)edgeInsets;

/*
 *  获取popupSuperview里的指定frame
 *
 *  @param popupSuperview               弹出视图的父视图view(可以为nil,为nil时候弹出到keyWindow上)
 *  @param popupViewSize                弹出视图的大小
 *  @param centerOffset                 弹窗弹出位置的中心与window中心的偏移量
 */
+ (CGRect)popupViewShowFrame_InCenterInView:(nullable UIView *)popupSuperview
                                   withSize:(CGSize)popupViewSize
                               centerOffset:(CGPoint)centerOffset;

@end

NS_ASSUME_NONNULL_END
