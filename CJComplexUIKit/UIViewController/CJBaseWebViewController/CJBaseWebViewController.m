//
//  CJBaseWebViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/2/6.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseWebViewController.h"

#ifdef CJTESTPOD
    #import "CJWebUtil.h"
#else
    #import <CJBaseUtil/CJWebUtil.h>
#endif


#import <SVProgressHUD/SVProgressHUD.h>

@interface CJBaseWebViewController ()

@property (nonatomic, copy) void (^showEmptyViewBlock)(NSString *message);//显示空白页的方法
@property (nonatomic, copy) void (^hideEmptyViewBlock)(void);//隐藏空白页的方法

@end


@interface CJBaseWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation CJBaseWebViewController

- (void)dealloc
{
    [CJWebUtil removeWebCache];
    
    //移除监听者
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGFloat progressViewMinX = 0;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarHeight = CGRectGetHeight(statusBarFrame);
    progressViewMinX += statusBarHeight;
    if (self.navigationController) {
        CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
        CGFloat navigationBarHeight = CGRectGetHeight(navigationBarFrame);
        progressViewMinX += navigationBarHeight;
    }
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
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
    
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.automaticallyAdjustsScrollViewInsets = NO; //若无导航栏的情况下，webview默认距离顶部20；所以要加这一行
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(20);
        make.bottom.mas_equalTo(self.view);
    }];
    
    /* progressView */
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    progressView.backgroundColor = [UIColor whiteColor];
    progressView.progressTintColor= [UIColor greenColor];//设置已过进度部分的颜色
    progressView.trackTintColor= [UIColor lightGrayColor];//设置未过进度部分的颜色
    [self.view addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_equalTo(2);
    }];
    self.progressView = progressView;
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
    //NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    NSString *localHtmlUrl = requestUrl;
    NSURL *localHtmlURL = [NSURL fileURLWithPath:localHtmlUrl];
    
    NSString *localHtmlString = [NSString stringWithContentsOfFile:localHtmlUrl encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:localHtmlString baseURL:localHtmlURL];
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
            self.navigationItem.title = self.webView.title;
            
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


//#pragma mark - WKNavigationDelegate 页面跳转的代理方法
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"页面跳转的代理方法--接收到服务器跳转请求之后调用");
//}
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    NSLog(@"页面跳转的代理方法--在收到响应后，决定是否跳转");
//}

//拦截URL:URL请求被WKNavigationDelegate中的代理方法拦截。也就是JS调用了OC。JS 调用OC 方法后，有的操作可能需要将结果返回给JS。这时候就是OC 调用JS 方法的场景。OC调用JS的方法为evaluateJavaScript:completionHandler:
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //NSLog(@"页面跳转的代理方法--在发送请求之前，决定是否跳转");
    
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


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD show];
    self.progressView.hidden = NO;
    [self.view bringSubviewToFront:self.progressView];
}

// 页面加载完成之后调用
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

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD dismiss];
    
    NSString *failureMessage = error.userInfo.description;
    [self showEmptyViewWithFailureMessage:failureMessage];
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
