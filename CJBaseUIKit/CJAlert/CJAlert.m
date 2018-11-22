//
//  CJAlert.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAlert.h"
#import "CJAlertView.h"

@implementation CJAlert

#pragma mark - UIAlertController
/* 完整的描述请参见文件头部 */
+ (void)showAlertTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 alertActions:(NSArray<UIAlertAction *> *)alertActions
                             inViewController:(UIViewController *)viewController
{
    [self showAlertControllerWithTitle:title
                               message:message
                        preferredStyle:UIAlertControllerStyleAlert
                          alertActions:(NSArray<UIAlertAction *> *)alertActions
                      inViewController:viewController];
}

/* 完整的描述请参见文件头部 */
+ (void)showSheetTypeAlertControllerWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 alertActions:(NSArray<UIAlertAction *> *)alertActions
                             inViewController:(UIViewController *)viewController
{
    [self showAlertControllerWithTitle:title
                               message:message
                        preferredStyle:UIAlertControllerStyleActionSheet
                          alertActions:(NSArray<UIAlertAction *> *)alertActions
                      inViewController:viewController];
}

+ (void)showAlertControllerWithTitle:(NSString *)title
                             message:(NSString *)message
                      preferredStyle:(UIAlertControllerStyle)preferredStyle
                        alertActions:(NSArray<UIAlertAction *> *)alertActions
                    inViewController:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];

    for (UIAlertAction *alertAction in alertActions) {
        [alertController addAction:alertAction];
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}




#pragma mark - CJAlertView
+ (void)showIKnowWithTitle:(NSString *)title message:(NSString *)message okHandle:(void(^)(void))okHandle {
    NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
    
    [self showAlertViewWithFlagImage:nil title:title message:message cancelButtonTitle:nil okButtonTitle:okButtonTitle cancelHandle:nil okHandle:okHandle];
}

+ (void)showIKnowAlertWithFlagImage:(UIImage *)flagImage title:(NSString *)title message:(NSString *)message okHandle:(void(^)(void))okHandle {
    NSString *okButtonTitle = NSLocalizedString(@"我知道了", nil);
    
    [self showAlertViewWithFlagImage:flagImage title:title message:message cancelButtonTitle:nil okButtonTitle:okButtonTitle cancelHandle:nil okHandle:okHandle];
}

+ (void)showCancelOKAlertWithTitle:(NSString *)title okHandle:(void(^)(void))okHandle {
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *okButtonTitle = NSLocalizedString(@"确定", nil);
    
    [self showAlertViewWithFlagImage:nil title:title message:nil cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:nil okHandle:okHandle];
}

+ (void)showAlertViewWithFlagImage:(UIImage *)flagImage
                             title:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                     okButtonTitle:(NSString *)okButtonTitle
                      cancelHandle:(void(^)(void))cancelHandle
                          okHandle:(void(^)(void))okHandle
{
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 200);
    
    CJAlertView *alertView = [CJAlertView alertViewWithSize:popupViewSize flagImage:flagImage title:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle cancelHandle:cancelHandle okHandle:okHandle];
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [alertView showWithShouldFitHeight:YES blankBGColor:blankBGColor];
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
    [message appendFormat:extraInfo];
    
    [CJAlert showDebugViewWithTitle:title message:message];
}

/* 完整的描述请参见文件头部 */
+ (void)showDebugViewWithTitle:(NSString *)title message:(NSString *)message
{    
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.9, 200);
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:10 secondVerticalInterval:10 thirdVerticalInterval:0 bottomMinVerticalInterval:10];
    
    //UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
    //[alertView addFlagImage:flagImage size:CGSizeMake(38, 38)];
    
    if (title.length > 0) {
        [alertView addTitleWithText:title font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:10 paragraphStyle:nil];
    }
    
    if (message.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.lineSpacing = 3;
        paragraphStyle.firstLineHeadIndent = 10;
        [alertView addMessageWithText:message font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentLeft margin:10 paragraphStyle:paragraphStyle];
        [alertView addMessageLayerWithBorderWidth:0.5 borderColor:nil cornerRadius:3];
    }
    
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *okButtonTitle = NSLocalizedString(@"复制到粘贴板", nil);
    [alertView addBottomButtonWithHeight:50 cancelButtonTitle:cancelButtonTitle okButtonTitle:okButtonTitle  cancelHandle:^{
        //NSLog(@"调试面板:点击了取消按钮");
    } okHandle:^{
        //NSLog(@"调试面板:调试信息已复制到粘贴板");
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = message;
    }];
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [alertView showWithShouldFitHeight:YES blankBGColor:blankBGColor];
}

@end
