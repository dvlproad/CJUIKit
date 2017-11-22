//
//  UIView+CJShowExtendView.h
//  CJPopupViewDemo
//
//  Created by lichq on 15/11/12.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CJPopupInView.h"


typedef NS_ENUM(NSUInteger, CJPopupViewPosition) {
    CJPopupViewPositionUnder
};

@interface UIView (CJShowExtendView)


#pragma mark - 外部接口
/**
 *  显示当前视图的弹出视图方法1（弹出视图popupView的位置及大小根据设置的location和size来确定)
 *
 *  @param popupView                  弹出视图popupView
 *  @param popupSuperview             弹出视图popupView的superview
 *  @param popupViewLocation          弹出视图popupView的位置location
 *  @param popupViewSize              弹出视图popupView的大小size
 *  @param showPopupViewCompleteBlock 显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock  点击空白区域后的操作
 */
- (void)cj_showExtendView:(UIView *)popupView
                   inView:(UIView *)popupSuperview
               atLocation:(CGPoint)popupViewLocation
                 withSize:(CGSize)popupViewSize
             showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
         tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock;


/**
 *  显示当前视图的弹出视图方法2（弹出视图popupView的位置根据其与参照视图accordingView的位置及关系来确定)
 *
 *  @param popupView                  弹出视图popupView
 *  @param popupSuperview             弹出视图popupView的superview
 *  @param accordingView              根据accordingView来取得弹出视图的应该的位置
 *  @param popupViewPosition          弹出视图popupView相对accordingView的位置
 *  @param showPopupViewCompleteBlock 显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock  点击空白区域后的操作
 */
- (void)cj_showExtendView:(UIView *)popupView
                   inView:(UIView *)popupSuperview
    locationAccordingView:(UIView *)accordingView
         relativePosition:(CJPopupViewPosition)popupViewPosition
             showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
         tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock;

/**
 *  隐藏下拉视图
 *
 *  @param animated 是否动画
 */
- (void)cj_hideExtendViewAnimated:(BOOL)animated;

@end
