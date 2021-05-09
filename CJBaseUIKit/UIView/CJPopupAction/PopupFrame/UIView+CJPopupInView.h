//
//  UIView+CJPopupInView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//
//  本视图弹出到指定视图(如window)中的方法

#import <UIKit/UIKit.h>
#import "UIView+CJPopupFrameAnimation.h"

typedef void(^CJTapBlankViewCompleteBlock)(void);


typedef NS_ENUM(NSUInteger, CJWindowPosition) {
    CJWindowPositionBottom = 0,
    CJWindowPositionCenter
};





NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJPopupInView) {
    
}
@property (nonatomic, assign, readonly, getter=isCJPopupViewShowing) BOOL cjPopupViewShowing;   /**< 判断当前是否有弹出视图显示 */

#pragma mark - 弹出到视图View
/*
 *  将本View以size大小弹出到showInView视图中location位置
 *
 *  @param popupSuperview               弹出视图的父视图view
 *  @param popupViewOrigin              弹出视图的左上角origin坐标
 *  @param popupViewSize                弹出视图的size大小
 *  @param showBeforeConfigBlock        显示弹出视图前的一些对视图定制操作(可为nil,为nil时候会内置默认设置背景颜色)
 *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInView:(nonnull UIView *)popupSuperview
            withOrigin:(CGPoint)popupViewOrigin
                  size:(CGSize)popupViewSize
 showBeforeConfigBlock:(void(^ _Nullable)(UIView *bBlankView, UIView *bRealPopupView))showBeforeConfigBlock
          showComplete:(void(^ _Nullable)(void))showPopupViewCompleteBlock
      tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock;
/*
 *  将当前视图弹出到视图view中央
 *
 *  @param popupSuperview               弹出视图的父视图view(可以为nil,为nil时候弹出到keyWindow上)
 *  @param animationType                弹出时候的动画采用的类型
 *  @param popupViewSize                弹出视图的大小
 *  @param centerOffset                 弹窗弹出位置的中心与window中心的偏移量
 *  @param showBeforeConfigBlock        显示弹出视图前的一些对视图定制操作(可为nil,为nil时候会内置默认设置背景颜色)
 *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInCenterInView:(nullable UIView *)popupSuperview
                 animationType:(CJAnimationType)animationType
                      withSize:(CGSize)popupViewSize
                  centerOffset:(CGPoint)centerOffset
         showBeforeConfigBlock:(void(^ _Nullable)(UIView *bBlankView, UIView *bRealPopupView))showBeforeConfigBlock
                  showComplete:(void(^ _Nullable)(void))showPopupViewCompleteBlock
              tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock;

/*
 *  将当前视图弹出到视图view底部
 *
 *  @param popupSuperview               弹出视图的父视图view(可以为nil,为nil时候弹出到keyWindow上)
 *  @param animationType                弹出时候的动画采用的类型
 *  @param popupViewHeight              弹出视图的高度
 *  @param edgeInsets                   弹窗与window的(左右下)边距
 *  @param showBeforeConfigBlock        显示弹出视图前的一些对视图定制操作(可为nil,为nil时候会内置默认设置背景颜色)
 *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInBottomInView:(nullable UIView *)popupSuperview
                 animationType:(CJAnimationType)animationType
                    withHeight:(CGFloat)popupViewHeight
                    edgeInsets:(UIEdgeInsets)edgeInsets
         showBeforeConfigBlock:(void(^ _Nullable)(UIView *bBlankView, UIView *bRealPopupView))showBeforeConfigBlock
                  showComplete:(void(^ _Nullable)(void))showPopupViewCompleteBlock
              tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock;


@end

NS_ASSUME_NONNULL_END
