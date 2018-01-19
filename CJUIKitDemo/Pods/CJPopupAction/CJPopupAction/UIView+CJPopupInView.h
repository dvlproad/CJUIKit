//
//  UIView+CJPopupInView.h
//  CJPopupViewDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^CJTapBlankViewCompleteBlock)(void);
typedef void(^CJShowPopupViewCompleteBlock)(void);


typedef NS_ENUM(NSUInteger, CJWindowPosition) {
    CJWindowPositionBottom = 0,
    CJWindowPositionCenter
};

typedef NS_ENUM(NSUInteger, CJAnimationType) {
    //    MJPopupViewAnimationFade = 0,
    //    MJPopupViewAnimationSlideBottomTop = 1,
    //    MJPopupViewAnimationSlideBottomBottom,
    //    MJPopupViewAnimationSlideTopTop,
    //    MJPopupViewAnimationSlideTopBottom,
    //    MJPopupViewAnimationSlideLeftLeft,
    //    MJPopupViewAnimationSlideLeftRight,
    //    MJPopupViewAnimationSlideRightLeft,
    //    MJPopupViewAnimationSlideRightRight,
    CJAnimationTypeNone = 0,   //Directly
    CJAnimationTypeNormal,     //通过设置frame来实现
    CJAnimationTypeCATransform3D
};

@interface UIView (CJPopupInView) {
    
}
@property (nonatomic, assign, readonly, getter=isCJPopupViewShowing) BOOL cjPopupViewShowing;   /**< 判断当前是否有弹出视图显示 */

/**
 *  将本View以size大小弹出到showInView视图中location位置
 *
 *  @param popupSuperview               弹出视图的父视图view
 *  @param popupViewOrigin              弹出视图的左上角origin坐标
 *  @param popupViewSize                弹出视图的size大小
 *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInView:(UIView *)popupSuperview
            withOrigin:(CGPoint)popupViewOrigin
                  size:(CGSize)popupViewSize
          showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
      tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock;


/**
 *  将当前视图弹出到window中央
 *
 *  @param animationType              弹出时候的动画采用的类型
 *  @param popupViewSize              弹出视图的大小
 *  @param showPopupViewCompleteBlock 显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock  点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInCenterWindow:(CJAnimationType)animationType
                      withSize:(CGSize)popupViewSize
                  showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
              tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock;


/**
 *  将当前视图弹出到window底部
 *
 *  @param animationType              弹出时候的动画采用的类型
 *  @param popupViewHeight            弹出视图的高度
 *  @param showPopupViewCompleteBlock 显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock  点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInBottomWindow:(CJAnimationType)animationType
                    withHeight:(CGFloat)popupViewHeight
                  showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
              tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock;

/**
 *  隐藏弹出视图
 */
- (void)cj_hidePopupView;
/**
 *  隐藏弹出视图
 */
- (void)cj_hidePopupViewWithAnimationType:(CJAnimationType)animationType;

@end
