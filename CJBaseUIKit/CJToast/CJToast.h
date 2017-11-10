//
//  CJToast.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

//提示语的实现是通过给MBProgressHUD写一个类目方法。

@interface CJToast : NSObject

#pragma mark - Only Text
/**
 *  在window上短暂的显示文字(灰底黑字，2秒后自动消失)
 *
 *  @param message  要显示的信息
 */
+ (void)shortShowMessage:(NSString*)message;

/**
 *  在window上短暂的显示文字(黑底白字，2秒后自动消失)
 *
 *  @param message  要显示的信息
 */
+ (void)shortShowWhiteMessage:(NSString*)message;

/**
 *  在指定的view上短暂的显示文字(灰底黑字，2秒后自动消失)
 *
 *  @param message  要显示的信息
 *  @param view     信息要显示的位置
 */
+ (void)shortShowMessage:(NSString *)message inView:(UIView *)view;

/**
 *  在指定的view上短暂的显示文字(黑底白字，2秒后自动消失)
 *
 *  @param message  要显示的信息
 *  @param view     信息要显示的位置
 */
+ (void)shortShowWhiteMessage:(NSString *)message inView:(UIView *)view;


/**
 *  在指定的view上短暂的显示文字(2秒后自动消失)
 *
 *  @param message          要显示的信息
 *  @param view             信息要显示的位置
 *  @param labelTextColor   文字的颜色
 *  @param bezelViewColor   文字所在背景框的颜色
 *  @param delay            多少秒后自动消失
 */
+ (void)shortShowMessage:(NSString *)message
                  inView:(UIView *)view
      withLabelTextColor:(UIColor *)labelTextColor
          bezelViewColor:(UIColor *)bezelViewColor
          hideAfterDelay:(NSTimeInterval)delay;



#pragma mark - Text And Image
/**
 *  在指定的view上短暂的显示文字及图片（0.7秒后自动消失）
 *
 *  @param message  要显示的文字
 *  @param image    要显示的图片
 *  @param view     要显示在的视图
 */
+ (void)shortShowMessage:(NSString *)message image:(UIImage *)image toView:(UIView *)view;


#pragma mark - Text And 菊花
/**
 *  显示菊花和信息(实际一般不用此方法,而直接写如CJTotalDemo中 AppDelegate+DefaultSetting.h 的数据库初始化)
 *
 *  @param message                  要显示的文字(可以为nil)
 *  @param view                     要显示在的视图
 *  @param showingOperationBlock    显示过程中要执行的操作(可以为nil，为nil的时候将在2秒后自动消失)
 */
+ (void)showChrysanthemumAndMessage:(NSString *)message
                             toView:(UIView *)view
          withShowingOperationBlock:(void(^)(MBProgressHUD *hud))showingOperationBlock;


#pragma mark - HUD
+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

@end
