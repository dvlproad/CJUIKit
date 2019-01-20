//
//  JSCallCameraViewController2.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "JSCallCameraViewController2.h"
#import "DemoButtonFactory.h"
#import <CJMedia/MySingleImagePickerController.h>
#import <CJBaseUIKit/UIImage+CJTransformSize.h>
#import <CJBaseUIKit/UIImage+CJBase64.h>
#import "DemoCacheUtil.h"

@interface JSCallCameraViewController2 () <WKUIDelegate, WKNavigationDelegate> {
    
}

@end

@implementation JSCallCameraViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"JS调用系统相册(网页版)", nil);
    
    self.networkUrl = @"http://gif.55.la/";
    
    self.webView.UIDelegate = self;
    //self.webView.navigationDelegate = self;
}


#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    NSLog(@"createWebViewWithConfiguration");
    
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

/// 通知您的应用程序DOM窗口成功关闭
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"webViewDidClose");
}

/// 显示一个 JavaScript 警告面板
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"runJavaScriptAlertPanelWithMessage");
    [CJToast shortShowMessage:message];
}

/// 显示一个 JavaScript 确认面板
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"runJavaScriptConfirmPanelWithMessage");
    [CJToast shortShowMessage:message];
}

/// 显示一个 JavaScript 文本输入面板
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    NSLog(@"runJavaScriptTextInputPanelWithPrompt");
    NSString *message = [NSString stringWithFormat:@"%@:%@", prompt, defaultText];
    [CJToast shortShowMessage:message];
}


/// 确定给定元素是否应显示预览
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
    NSLog(@"shouldPreviewElement");
    return YES;
}

/// 当用户执行窥视操作时调用
- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions {
    NSLog(@"previewingViewControllerForElement");
    return nil;
}

/// 当用户在预览中执行弹出操作时调用
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {
    NSLog(@"commitPreviewingViewController");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
