//
//  CQAlertUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQAlertUtil : NSObject 

#pragma mark - 常用的接口（简洁接口）
///显示只有一个 "我知道了" 的 alertView
+ (void)showIKnowAlertViewWithTitle:(NSString *_Nullable)title
                            message:(NSString *_Nullable)message
                           okHandle:(void(^_Nullable)(void))okHandle;


///显示 "取消" + "确定" 的 alertView
+ (void)showCancelAndOKAlertViewWithTitle:(NSString *_Nullable)title
                                  message:(NSString *_Nullable)message
                             cancelHandle:(void(^_Nullable)(void))cancelHandle
                                 okHandle:(void(^_Nullable)(void))okHandle;


#pragma mark - 完整的基本接口（请优先考虑上述的常用接口）
/*
*  显示自定义 "OK" 的 alertView
*
*  @param flagImage             弹框顶部的图片
*  @param title                 弹框的标题
*  @param message               message
*  @param okButtonTitle        确认的文本
*  @param okHandle              确认的事件
*/
+ (void)showAlertViewWithFlagImage:(nullable UIImage *)flagImage
                             title:(nullable NSString *)title
                           message:(nullable NSString *)message
                     okButtonTitle:(NSString *)okButtonTitle
                          okHandle:(void(^_Nullable)(void))okHandle;

/*
 *  显示自定义 "Cancel" + "OK" 的 alertView
 *
 *  @param flagImage            弹框顶部的图片
 *  @param title                弹框的标题
 *  @param message              message
 *  @param cancelButtonTitle    取消的文本
 *  @param okButtonTitle        确认的文本
 *  @param cancelHandle         取消的事件
 *  @param okHandle             确认的事件
 */
+ (void)showAlertViewWithFlagImage:(nullable UIImage *)flagImage
                             title:(nullable NSString *)title
                           message:(nullable NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                     okButtonTitle:(NSString *)okButtonTitle
                      cancelHandle:(void(^_Nullable)(void))cancelHandle
                          okHandle:(void(^_Nullable)(void))okHandle;

/*
 *  显示文本输入的弹窗
 *
 *  @param title                弹框的标题
 *  @param inputText            文本框的text
 *  @param placeholder          文本框的placeholder
 *  @param cancelButtonTitle    取消的文本
 *  @param okButtonTitle        确认的文本
 *  @param cancelHandle         取消的事件
 *  @param okHandle             确认的事件
 */
+ (void)showAlertViewWithTitle:(nullable NSString *)title
                      inputText:(nullable NSString *)inputText
                   placeholder:(nullable NSString *)placeholder
             cancelButtonTitle:(NSString *)cancelButtonTitle
                 okButtonTitle:(NSString *)okButtonTitle
                  cancelHandle:(void(^_Nullable)(void))cancelHandle
                      okHandle:(void(^_Nullable)(NSString *outputText))okHandle;




#pragma mark - DebugView
/*
 *  显示调试面板
 *
 *  @param title                调试面板的标题
 *  @param message              调试面板的信息
 *  @param shouldContailAppInfo 调试面板的信息是否包含app信息
 */
+ (void)showDebugViewWithTitle:(NSString *)title
                       message:(NSString *)message
          shouldContailAppInfo:(BOOL)shouldContailAppInfo;

@end

NS_ASSUME_NONNULL_END
