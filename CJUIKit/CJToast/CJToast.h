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

#pragma mark - Totast
/**
 *  在window上显示文字(显示时常已默认设置成2秒)
 *
 *  @param message  要显示的信息
 */
+ (void)showMessage:(NSString*)message;

/**
 *  在指定的view上显示文字(显示时常已默认设置成2秒)
 *
 *  @param message  要显示的信息
 *  @param view     信息要显示的位置
 */
+ (void)showMessage:(NSString *)message inView:(UIView *)view;


/**
 *  显示文字及图片（并在0.7秒后自动消失）
 *
 *  @param message  要显示的文字
 *  @param image    要显示的图片
 *  @param view     要显示在的视图
 */
+ (void)showMessage:(NSString *)message image:(UIImage *)image view:(UIView *)view;


#pragma mark - HUD
+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

@end
