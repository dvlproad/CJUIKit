//
//  CJWebUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  其他参考：
//  [删除WKWebView的缓存](http://blog.csdn.net/amateur__7/article/details/49658193)
//  [WKWebView从入门到趟坑](http://www.jianshu.com/p/90a90bd13aac)
//  [iOS webview加载时序和缓存问题总结](http://www.cnblogs.com/lolDragon/p/6774509.html)

#import <WebKit/WebKit.h>

@interface CJWebUtil : NSObject

/**
 *  删除Web的缓存(兼容iOS8)
 */
+ (void)removeWebCache;

@end
