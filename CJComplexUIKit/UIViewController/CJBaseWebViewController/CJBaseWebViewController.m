//
//  CJBaseWebViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2018/2/6.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseWebViewController.h"

#ifdef TEST_CJCOMPLEXUIKIT_POD
    #import "WebCJHelper.h"
#else
    #import <CJBaseHelper/WebCJHelper.h>
#endif


#import <SVProgressHUD/SVProgressHUD.h>

@interface CJBaseWebViewController () {
    
}
@property (nonatomic, copy) void (^showEmptyViewBlock)(NSString *message);//显示空白页的方法
@property (nonatomic, copy) void (^hideEmptyViewBlock)(void);//隐藏空白页的方法

@end


@interface CJBaseWebViewController () <WKNavigationDelegate> {
    
}
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign, readonly) BOOL oldTranslucent;

@end

@implementation CJBaseWebViewController

- (void)dealloc
{
    [WebCJHelper removeWebCache];
    
    //移除监听者
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = self.oldTranslucent;
    
    [SVProgressHUD dismiss];//容错处理:避免有时候加载未完成时候需要返回
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _oldTranslucent = self.navigationController.navigationBar.translucent;
    if (_oldTranslucent == NO) { //外部将translucent设为了NO，会导致原本视图布局有问题
        self.navigationController.navigationBar.translucent = YES;
    }
    
    CGFloat progressViewMinX = 0;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarHeight = CGRectGetHeight(statusBarFrame);
    if (self.navigationController) {
        CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
        CGFloat navigationBarHeight = CGRectGetHeight(navigationBarFrame);
        progressViewMinX = statusBarHeight + navigationBarHeight;
    } else {
        progressViewMinX = statusBarHeight;
    }
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(progressViewMinX);
    }];
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(progressViewMinX);
    }];
    
    /*
    请在子类中调用
    BOOL networkEnable = [AppInfoManager sharedInstance].networkEnable;
    [self reloadNetworkWebWithUrl:<#(NSString *)#> networkEnable:<#(BOOL)#>];
    或
    [self reloadLocalWebWithUrl:<#(NSString *)#>];
    */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.useWebTitle = YES; //默认使用 web title
    
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(self.view);
    }];
    
    /* progressView */
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    progressView.backgroundColor = [UIColor whiteColor];
    progressView.progressTintColor = [UIColor greenColor];//设置已过进度部分的颜色
    progressView.trackTintColor = [UIColor lightGrayColor];//设置未过进度部分的颜色
    progressView.hidden = YES;
    [self.view addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_equalTo(2);
    }];
    self.progressView = progressView;
}

- (void)setTodoProgressColor:(UIColor *)todoProgressColor {
    _todoProgressColor = todoProgressColor;
    self.progressView.trackTintColor = self.todoProgressColor;//设置未过进度部分的颜色
}

- (void)setDoneProgressColor:(UIColor *)doneProgressColor {
    _doneProgressColor = doneProgressColor;
    self.progressView.progressTintColor = self.doneProgressColor;//设置已过进度部分的颜色
}

- (void)setProgressHeight:(CGFloat)progressHeight {
    _progressHeight = progressHeight;
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(progressHeight);
    }];
}


/**
 *  加载网络网页
 *
 *  @param requestUrl       网页地址
 *  @param networkEnable    是否有网
 */
- (void)reloadNetworkWebWithUrl:(NSString *)requestUrl networkEnable:(BOOL)networkEnable {
    //注：如果发现地址等都正常，但是页面还是显示无数据页，请检查info.plist中的App Transport Security Settings
    if (networkEnable == NO) {
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self showEmptyViewWithFailureMessage:NSLocalizedString(@"请检查您的手机是否联网", nil)];
        });
        
    } else {
        //通过URL，创建Request并加载
        NSURL *URL = [NSURL URLWithString:requestUrl];;
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:request];
    }
}

/**
 *  加载本地网页
 *
 *  @param requestUrl   网页地址
 */
- (void)reloadLocalWebWithUrl:(NSString *)requestUrl {
    //NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"localWeb.html" ofType:nil];
    NSString *localHtmlUrl = requestUrl;
    NSURL *localHtmlURL = [NSURL fileURLWithPath:localHtmlUrl];
    
    //NSString *localHtmlString = [NSString stringWithContentsOfFile:localHtmlUrl encoding:NSUTF8StringEncoding error:nil];
    NSString *localHtmlString = [NSString stringWithContentsOfURL:localHtmlURL encoding:NSUTF8StringEncoding error:nil];
    
    //NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]];
    NSURL *baseURL = localHtmlURL;
    [self.webView loadHTMLString:localHtmlString baseURL:baseURL];
}

//添加KVO监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (object == self.webView)
    {
        if ([keyPath isEqualToString:@"estimatedProgress"]) { //加载进度值
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.5f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
//                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
//                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        } else if ([keyPath isEqualToString:@"title"]) { //网页title
            if (self.useWebTitle) {
                self.navigationItem.title = self.webView.title;
            }
            
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - WKNavigationDelegate 页面跳转的代理方法
//1.拦截URL:URL请求被WKNavigationDelegate中的代理方法拦截。也就是JS调用了OC。JS 调用OC 方法后，有的操作可能需要将结果返回给JS。这时候就是OC 调用JS 方法的场景。OC调用JS的方法为evaluateJavaScript:completionHandler:
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //NSLog(@"1.页面跳转的代理方法--在发送请求之前，决定是否跳转");
    // 必须实现decisionHandler的回调，否则就会报错
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    
    if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        
    } else if ([scheme isEqualToString:@"tel"]) {
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:URL]];
        [self.view addSubview:callWebview];
        
        decisionHandler(WKNavigationActionPolicyCancel);
        
    } else if ([scheme isEqualToString:@"weixin"]) {
        if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL])
        {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {

                }];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
            }
        }

        decisionHandler(WKNavigationActionPolicyCancel);
        
    } else if ([scheme isEqualToString:@"handleCustomAction"]) { //js代码形为loadURL("scheme://getLocation");的时候,可以通过拦截URL来调用本次方法
//        NSString *host = [URL host];
//        if ([host isEqualToString:@"scanClick"]) {
//            NSLog(@"扫一扫");
//        } else if ([host isEqualToString:@"shareClick"]) {
//            [self share:URL];
//        } else if ([host isEqualToString:@"getLocation"]) {
//            [self getLocation];
//        } else if ([host isEqualToString:@"setColor"]) {
//            [self changeBGColor:URL];
//        } else if ([host isEqualToString:@"payAction"]) {
//            [self payAction:URL];
//        } else if ([host isEqualToString:@"shake"]) {
//            [self shakeAction];
//        } else if ([host isEqualToString:@"goBack"]) {
//            [self goBack];
//        }
        
        decisionHandler(WKNavigationActionPolicyCancel);
        
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}


// 2.页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD show];
    self.progressView.hidden = NO;
    [self.view bringSubviewToFront:self.progressView];
}


// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD dismiss];
    self.progressView.hidden = YES;
    //    [self.webView removeFromSuperview];
    
    NSString *failureMessage = error.userInfo.description;
    if (error.code == -1022) {
        failureMessage = @"the App Transport Security policy requires the use of a secure connection.";
    }
    [self showEmptyViewWithFailureMessage:failureMessage];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"3.页面跳转的代理方法--在收到响应后，决定是否跳转");
    NSLog(@"navigationResponse = %@", navigationResponse);
    NSLog(@"navigationResponse.response = %@", navigationResponse.response);
    // 必须实现decisionHandler的回调，否则就会报错
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"页面跳转的代理方法--接收到服务器跳转请求之后调用");
}


// 4.1页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
    self.progressView.hidden = YES;
    
    if (self.hideEmptyViewBlock) {
        self.hideEmptyViewBlock();
    }
    
    if (self.webViewDidFinishNavigationBlcok) {
        self.webViewDidFinishNavigationBlcok(webView);
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD dismiss];
    
    NSString *failureMessage = error.userInfo.description;
    [self showEmptyViewWithFailureMessage:failureMessage];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"didReceiveAuthenticationChallenge");
    // 判断服务器采用的验证方法
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        // 如果没有错误的情况下 创建一个凭证，并使用证书
        if (challenge.previousFailureCount == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            // 验证失败，取消本次验证
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        
    }
}

/*! @abstract Invoked when the web view's web content process is terminated.
 @param webView The web view whose underlying web content process was terminated.
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"webViewWebContentProcessDidTerminate");
}


- (void)showEmptyViewWithFailureMessage:(NSString *)failureMessage {
    if (self.showEmptyViewBlock) {
        self.showEmptyViewBlock(failureMessage);
    }    
}

- (void)setupShowEmptyViewBlock:(void (^)(NSString *))showEmptyViewBlock
             hideEmptyViewBlock:(void (^)(void))hideEmptyViewBlock
{
    self.showEmptyViewBlock = showEmptyViewBlock;
    self.hideEmptyViewBlock = hideEmptyViewBlock;
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


#pragma mark ---------  懒加载  --------------
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        
        /* ①设置 WKWebViewConfiguration -- WKPreferences */
        WKPreferences *preferences = [[WKPreferences alloc] init];
        configuration.preferences = preferences;
        
        /* ②设置 WKWebViewConfiguration -- WKProcessPool */
        WKProcessPool *processPool = [[WKProcessPool alloc] init];
        configuration.processPool = processPool;
        
        /* ③设置 WKWebViewConfiguration -- WKUserContentController */
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        self.userContentController = userContentController;
        configuration.userContentController = userContentController;
        
        
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        webView.navigationDelegate = self;
        
        /* 添加kvo监听，获得页面title和加载进度值 */
        [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        
        _webView = webView;
    }
    return _webView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
