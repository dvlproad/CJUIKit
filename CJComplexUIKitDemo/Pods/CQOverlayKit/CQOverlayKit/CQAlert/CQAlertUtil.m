//
//  CQAlertUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQAlertUtil.h"
#import <CJBaseOverlayKit/CJMessageAlertView.h>
#import <CJBaseOverlayKit/CJTextInputAlertView.h>
#import "CJBaseAlertView+CQPopupAction.h"

#import "CQOverlayTheme.h"

@implementation CQAlertUtil

#pragma mark - 常用的接口（简洁接口）
///显示只有一个 "我知道了" 的 alertView
+ (void)showIKnowAlertViewWithTitle:(NSString *_Nullable)title
                            message:(NSString *_Nullable)message
                           okHandle:(void(^_Nullable)(void))okHandle
{
    NSString *alertIKonwText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.alertIKonwText;
    [self showAlertViewWithFlagImage:nil
                               title:title
                             message:message
                       okButtonTitle:alertIKonwText //NSLocalizedString(@"我知道了", nil)
                            okHandle:okHandle];
}


///显示 "取消" + "确定" 的 alertView
+ (void)showCancelAndOKAlertViewWithTitle:(NSString *)title
                                  message:(NSString *)message
                             cancelHandle:(void(^_Nullable)(void))cancelHandle
                                 okHandle:(void(^_Nullable)(void))okHandle
{
    NSString *alertCancelText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.alertCancelText;
    NSString *alertOKText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.alertOKText;
   [self showAlertViewWithFlagImage:nil
                              title:title
                            message:message
                  cancelButtonTitle:alertCancelText //NSLocalizedString(@"取消", nil)
                      okButtonTitle:alertOKText     //NSLocalizedString(@"确定", nil)
                       cancelHandle:cancelHandle
                           okHandle:okHandle];
}

#pragma mark - DebugView
/* 完整的描述请参见文件头部 */
+ (void)showDebugViewWithAppExtraInfo:(NSString *)extraInfo {
    NSString *title = @"app信息";
    
    CJMessageAlertView *alertView = [CJMessageAlertView debugMessageAlertViewWithTitle:title message:extraInfo shouldContailAppInfo:YES];
    
    [self __showMessageAlertView:alertView];
}


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
                          okHandle:(void(^_Nullable)(void))okHandle
{
    CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:flagImage title:title message:message okButtonTitle:okButtonTitle okHandle:okHandle];
    
    [self __showMessageAlertView:alertView];
}

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
{
    CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:cancelHandle okHandle:okHandle];
    
    [self __showMessageAlertView:alertView];
}


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
                      okHandle:(void(^_Nullable)(NSString *outputText))okHandle
{
    CJTextInputAlertView *alertView = [[CJTextInputAlertView alloc] initWithTitle:title inputText:inputText placeholder:placeholder cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:cancelHandle okHandle:okHandle];
    
    [self __showTextInputAlertView:alertView];
}


/// 显示调试面板
/// @param title                                        调试面板的标题
/// @param message                                   调试面板的信息
/// @param shouldContailAppInfo      调试面板的信息是否包含app信息
+ (void)showDebugViewWithTitle:(NSString *)title
                       message:(NSString *)message
          shouldContailAppInfo:(BOOL)shouldContailAppInfo
{
    CJMessageAlertView *alertView = [CJMessageAlertView debugMessageAlertViewWithTitle:title message:message shouldContailAppInfo:shouldContailAppInfo];
    
    [self __showMessageAlertView:alertView];
}



#pragma mark - Private Method
+ (void)__showMessageAlertView:(CJMessageAlertView *)alertView {
    [alertView showWithShouldFitHeight:YES];
}

+ (void)__showTextInputAlertView:(CJTextInputAlertView *)alertView {
    [alertView showWithShouldFitHeight:YES];
}





@end
