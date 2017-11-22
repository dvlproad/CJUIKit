//
//  UIView+CJPopupInView.h
//  CJPopupViewDemo
//
//  Created by lichq on 15/11/12.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
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
 *  @param showInView                 弹出视图的父view
 *  @param location                   弹出视图的位置
 *  @param size                       弹出视图的大小
 *  @param showPopupViewCompleteBlock 显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock  点击空白区域后的操作
 */
- (void)cj_popupInView:(UIView *)showInView
            atLocation:(CGPoint)location
              withSize:(CGSize)size
          showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
      tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock;


/**
 *  将当前视图弹出到window中
 *
 *  @param windowPosition             当前视图在window中的位置
 *  @param animationType              弹出时候的动画采用的类型
 *  @param showPopupViewCompleteBlock 显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock  点击空白区域后的操作
 */
- (void)cj_popupInWindowAtPosition:(CJWindowPosition)windowPosition
                     animationType:(CJAnimationType)animationType
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
