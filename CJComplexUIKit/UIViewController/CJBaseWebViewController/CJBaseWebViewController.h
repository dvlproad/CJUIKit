//
//  CJBaseWebViewController.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2018/2/6.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  概述：UIWebView加载速度慢、占用内存大的问题。使用UIWebView加载网页的时候，我们会发现内存会无限增长，还有内存泄漏的问题存在。ios8后,苹果推出了WKWebView，它很好的解决了UIWebView存在的内存、加载速度等诸多问题。
//  参考：[WKWebView详解](https://www.cnblogs.com/Mr-Ygs/p/6061869.html)
//       [关于UIWebView的总结](http://blog.devtang.com/2012/03/24/talk-about-uiwebview-and-phonegap/)
//  常见问题：
//  注：如果发现地址等都正常，但是页面还是显示无数据页，请检查info.plist中的App Transport Security Settings
//  ①网页无法定位：解决方法info.plist添加Privacy - Microphone Usage Description等权限即可
//  ②电话无法拨打：解决方法URL拦截, scheme等于tel，app来拨打
//  ③微信等无法被调起：解决方法URL拦截, scheme等于weixin，[UIApplication sharedApplication] openURL

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>

//#import <JavaScriptCore/JavaScriptCore.h>                   //系统JS与OC交互
//#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h> //第三方JS与OC交互

#import "CJEmptyViewProtocol.h"

///只有实现CJEmptyViewProtocol中的方法才能显示空白时候的页面
@interface CJBaseWebViewController : UIViewController <CJEmptyViewProtocol> {
    
}
//非必选：页面加载完成之后执行的方法
@property (nonatomic, copy) void (^webViewDidFinishNavigationBlcok)(WKWebView *webView);


/**
 *  加载网络网页
 *
 *  @param requestUrl       网页地址
 *  @param networkEnable    是否有网
 */
- (void)reloadNetworkWebWithUrl:(NSString *)requestUrl networkEnable:(BOOL)networkEnable;

/**
 *  加载本地网页
 *
 *  @param requestUrl   网页地址
 */
- (void)reloadLocalWebWithUrl:(NSString *)requestUrl;

@end
