//
//  CJAlertUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJAlertUtil.h"
#import "CJMessageAlertView.h"
#import "CJTextInputAlertView.h"


@implementation CJAlertUtil

#pragma mark - 常用的接口
///显示只有一个 "我知道了" 的 alertView
+ (void)showIKnowAlertViewWithTitle:(NSString *_Nullable)title
                            message:(NSString *_Nullable)message
                           okHandle:(void(^_Nullable)(void))okHandle
{
    [self showAlertViewWithFlagImage:nil
                               title:title
                             message:message
                       okButtonTitle:NSLocalizedString(@"我知道了", nil)
                            okHandle:okHandle];
}


///显示 "取消" + "确定" 的 alertView
+ (void)showCancelAndOKAlertViewWithTitle:(NSString *)title
                                  message:(NSString *)message
                             cancelHandle:(void(^_Nullable)(void))cancelHandle
                                 okHandle:(void(^_Nullable)(void))okHandle
{
   [self showAlertViewWithFlagImage:nil
                              title:title
                            message:message
                  cancelButtonTitle:NSLocalizedString(@"取消", nil)
                      okButtonTitle:NSLocalizedString(@"确定", nil)
                       cancelHandle:cancelHandle
                           okHandle:okHandle];
}

#pragma mark - DebugView
/* 完整的描述请参见文件头部 */
+ (void)showDebugViewWithAppExtraInfo:(NSString *)extraInfo {
    NSString *title = @"app信息";
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"]; //app名
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//版本号
    NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];//buidId
    
    NSMutableString *message = [NSMutableString string];
    [message appendFormat:@"appName:%@\n", appName];
    [message appendFormat:@"appVersion:%@\n", appVersion];
    [message appendFormat:@"appBuild:  %@\n", appBuild];
    [message appendString:extraInfo];
    
    [self showDebugViewWithTitle:title message:message];
}


/// 显示调试面板
/// @param title          调试面板的标题
/// @param message      调试面板的信息
+ (void)showDebugViewWithTitle:(NSString *)title message:(NSString *)message
{
//    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
//    CGSize popupViewSize = CGSizeMake(screenWidth * 0.9, 200);
//    CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithSize:popupViewSize];
    CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:nil title:title message:message cancelButtonTitle:NSLocalizedString(@"取消", nil) okButtonTitle:NSLocalizedString(@"复制到粘贴板", nil) cancelHandle:^{
        //NSLog(@"调试面板:点击了取消按钮");
    } okHandle:^{
        //NSLog(@"调试面板:调试信息已复制到粘贴板");
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = message;
    }];
    alertView.messageScrollView.layer.borderWidth = 0.5;
    //alertView.messageScrollView.layer.borderColor = borderColor;
    alertView.messageScrollView.layer.cornerRadius = 3;
    
    
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




#pragma mark - Private Method
+ (void)__showMessageAlertView:(CJMessageAlertView *)alertView {
//    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    UIColor *blankBGColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    [alertView showWithShouldFitHeight:YES blankBGColor:blankBGColor];
}

+ (void)__showTextInputAlertView:(CJTextInputAlertView *)alertView {
    UIColor *blankBGColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    [alertView showWithShouldFitHeight:YES blankBGColor:blankBGColor];
}



@end
