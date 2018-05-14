//
//  BaseWebViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/2/6.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  概述：UIWebView加载速度慢、占用内存大的问题。使用UIWebView加载网页的时候，我们会发现内存会无限增长，还有内存泄漏的问题存在。ios8后,苹果推出了WKWebView，它很好的解决了UIWebView存在的内存、加载速度等诸多问题。
//  参考：[WKWebView详解](https://www.cnblogs.com/Mr-Ygs/p/6061869.html)
//       [关于UIWebView的总结](http://blog.devtang.com/2012/03/24/talk-about-uiwebview-and-phonegap/)
//  常见问题：
//  ①网页无法定位：解决方法info.plist添加Privacy - Microphone Usage Description等权限即可
//  ②电话无法拨打：解决方法URL拦截, scheme等于tel，app来拨打
//  ③软件无法拨打：解决方法URL拦截, scheme等于itms-services，[UIApplication sharedApplication] openURL
//  ④微信无法被调起：解决方法URL拦截, scheme等于weixin，[UIApplication sharedApplication] openURL

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//#import <JavaScriptCore/JavaScriptCore.h>                   //系统JS与OC交互
//#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h> //第三方JS与OC交互

#import "CJEmptyViewProtocol.h"

@interface BaseWebViewController : UIViewController <CJEmptyViewProtocol> {
    
}
///页面加载完成之后执行的方法
@property (nonatomic, copy) void (^webViewDidFinishNavigationBlcok)(WKWebView *webView);

- (void)reloadNetworkWebWithUrl:(NSString *)requestUrl networkEnable:(BOOL)networkEnable;

- (void)reloadLocalWebWithUrl:(NSString *)requestUrl;

@end
