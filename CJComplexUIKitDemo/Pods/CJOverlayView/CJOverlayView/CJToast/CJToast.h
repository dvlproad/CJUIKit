//
//  CJToast.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

//提示语的实现是通过给MBProgressHUD写一个类目方法。

@interface CJToast : NSObject

#pragma mark - Only Text
/*
 *  在指定的view上显示文字，并在delay秒后自动消失
 *
 *  @param message          要显示的信息
 *  @param view             信息要显示的位置
 *  @param labelTextColor   文字的颜色
 *  @param bezelViewColor   文字所在背景框的颜色
 *  @param delay            多少秒后自动消失
 */
+ (void)showMessage:(NSString *)message
             inView:(UIView *)view
 withLabelTextColor:(UIColor * _Nullable)labelTextColor
     bezelViewColor:(UIColor * _Nullable)bezelViewColor
     hideAfterDelay:(NSTimeInterval)delay;



#pragma mark - Text And Image
/**
 *  在指定的view上短暂的显示文字及图片（delay秒后自动消失）
 *
 *  @param message  要显示的文字
 *  @param image    要显示的图片
 *  @param view     要显示在的视图
 */
+ (void)showMessage:(NSString *)message
              image:(UIImage *)image
             toView:(UIView *)view
     hideAfterDelay:(NSTimeInterval)delay;


#pragma mark - Text And 菊花
/**
 *  创建一个显示菊花和信息的上下结构HUD(实际一般不用此方法,而是直接写如CJTotalDemo中 AppDelegate+DefaultSetting.h 的数据库初始化)
 *
 *  @param message                  要显示的文字(可以为nil)
 *  @param view                     要显示在的视图
 */
+ (MBProgressHUD *)createChrysanthemumHUDWithMessage:(NSString *)message toView:(UIView * _Nullable)view;

/**
 *  exec operation With HUD
 *
 *  @param startProgressMessage startProgressMessage
 *  @param endProgressMessage   endProgressMessage
 *  @param operationHandle      operationHandle
 */
+ (void)execOperationWithStartMessage:(NSString *)startProgressMessage
                           endMessage:(NSString *)endProgressMessage
                      operationHandle:(void (^ _Nullable)(void))operationHandle;

///**
// *  TODO:创建一个显示菊花和信息的左右结构HUD(实际一般不用此方法,而是直接写如CJTotalDemo中 AppDelegate+DefaultSetting.h 的数据库初始化)
// *
// *  @param message                  要显示的文字(可以为nil)
// *  @param view                     要显示在的视图
// */
//+ (MBProgressHUD *)createChrysanthemumHUDWithRightMessage:(NSString *)message toView:(UIView *)view;


@end

NS_ASSUME_NONNULL_END
