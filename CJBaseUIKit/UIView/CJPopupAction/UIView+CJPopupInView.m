//
//  UIView+CJPopupInView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupInView.h"
#import <objc/runtime.h>
#import "CJBasePopupInfo.h"
#import "PopupViewAddCJHelper.h"
#import "PopupViewFrameCJHelper.h"

#define CJPopupMainThreadAssert() NSAssert([NSThread isMainThread], @"UIView+CJPopupInView needs to be accessed on the main thread.");


static NSString *cjPopupViewHideFrameStringKey = @"cjPopupViewHideFrameString";

static NSString *cjPopupViewShowingKey = @"cjPopupViewShowing";


@interface UIView ()

@property (nonatomic, assign, readonly) CJAnimationType cjPopupAnimationType;   /**< 弹出视图的动画方式 */
//@property (nonatomic, assign) CATransform3D cjPopupViewHideTransform;/**< 弹出视图隐藏时候的transform */

@end


@implementation UIView (CJPopupInView)

#pragma mark - runtime
//cjPopupViewHideFrameString
- (NSString *)cjPopupViewHideFrameString {
    return objc_getAssociatedObject(self, &cjPopupViewHideFrameStringKey);
}

- (void)setCjPopupViewHideFrameString:(NSString *)cjPopupViewHideFrameString {
    return objc_setAssociatedObject(self, &cjPopupViewHideFrameStringKey, cjPopupViewHideFrameString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjPopupViewShowing
- (BOOL)isCJPopupViewShowing {
    return [objc_getAssociatedObject(self, &cjPopupViewShowingKey) boolValue];
}

- (void)setCjPopupViewShowing:(BOOL)cjPopupViewShowing {
    objc_setAssociatedObject(self, &cjPopupViewShowingKey, @(cjPopupViewShowing), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - 底层接口:弹出到视图View
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
{
    NSAssert(popupViewSize.width != 0 && popupViewSize.height != 0, @"弹出视图的宽高都不能为0");
    
    if (popupSuperview == nil) {
        popupSuperview = [[UIApplication sharedApplication] keyWindow];
    }
    
    // popupView改成添加到blankView中
    CGRect popupViewShowFrame = CGRectMake(popupViewOrigin.x, popupViewOrigin.y,
                                           popupViewSize.width, popupViewSize.height);
    
    CJBasePopupInfo *popupInfo = [PopupViewAddCJHelper addSubviewForPopupSuperview:popupSuperview
                                                               withBlankViewBelong:CJBlankViewBelongPopupView
                                                                         popupView:self
                                                                    tapBlankHandle:tapBlankViewCompleteBlock];
    
    // 弹出前的设置
    UIView *blankView = popupInfo.blankView;
    if (showBeforeConfigBlock == nil) {
        blankView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    } else {
        showBeforeConfigBlock(blankView, self);
    }
    
    // 开始弹出
    [self cj_animateToShowFrame:popupViewShowFrame
                     isToBottom:NO
                  animationType:CJAnimationTypeNormal
                   showComplete:showPopupViewCompleteBlock];
}

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
              tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock
{
    if (popupSuperview == nil) {
        popupSuperview = [[UIApplication sharedApplication] keyWindow];
    }
    
    // popupView改成添加到blankView中
    CGRect popupViewShowFrame = [PopupViewFrameCJHelper popupViewShowFrame_InCenterInView:popupSuperview
                                                                                 withSize:popupViewSize
                                                                             centerOffset:centerOffset];
    CJBasePopupInfo *popupInfo = [PopupViewAddCJHelper addSubviewForPopupSuperview:popupSuperview
                                                               withBlankViewBelong:CJBlankViewBelongPopupView
                                                                         popupView:self
                                                                    tapBlankHandle:tapBlankViewCompleteBlock];
    
    // 弹出前的设置
    UIView *blankView = popupInfo.blankView;
    if (showBeforeConfigBlock == nil) {
        blankView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    } else {
        showBeforeConfigBlock(blankView, self);
    }
    
    // 开始弹出
    [self cj_animateToShowFrame:popupViewShowFrame
                     isToBottom:NO
                  animationType:CJAnimationTypeNormal
                   showComplete:showPopupViewCompleteBlock];
}


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
              tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock
{
    if (popupSuperview == nil) {
        popupSuperview = [[UIApplication sharedApplication] keyWindow];
    }
    
    CGRect popupViewShowFrame = [PopupViewFrameCJHelper popupViewShowFrame_inBottomInView:popupSuperview
                                                                               withHeight:popupViewHeight
                                                                               edgeInsets:edgeInsets];
    CJBasePopupInfo *popupInfo = [PopupViewAddCJHelper addSubviewForPopupSuperview:popupSuperview
                                                               withBlankViewBelong:CJBlankViewBelongPopupView
                                                                         popupView:self
                                                                    tapBlankHandle:tapBlankViewCompleteBlock];
    
    // 弹出前的设置
    UIView *blankView = popupInfo.blankView;
    if (showBeforeConfigBlock == nil) {
        blankView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    } else {
        showBeforeConfigBlock(blankView, self);
    }
    
    // 开始弹出
    [self cj_animateToShowFrame:popupViewShowFrame
                     isToBottom:YES
                  animationType:CJAnimationTypeNormal
                   showComplete:showPopupViewCompleteBlock];
}


@end
