//
//  CJLogWindow.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  在以下文章中做的优化：[一个在 iOS 设备屏幕上实时打印 Log 的小工具](https://www.jianshu.com/p/4ebb1f3973bf)
//  TODO:设置为类似微信小程序，有个悬浮入口，也可关闭

#import <UIKit/UIKit.h>

/**
 *  一个在 iOS 设备屏幕上实时打印 Log 的小工具
 */
@interface CJLogWindow : UIWindow

+ (CJLogWindow *)sharedInstance;

/**
 *  将appendObject追加写入指定文件末尾(log文件统一存放在NSDocumentDirectory下的CJLog文件夹中)
 *
 *  @param appendObject     要追加写入的数据（NSData、NSString、NSDictrionary、NSArray）
 *  @param logWindowName    追加的内容要写入的指定log窗口的标志名
 */
+ (void)cj_appendObject:(id)appendObject toLogWindowName:(NSString *)logWindowName;

///**
// *  关闭指定的log窗口
// *
// *  @param logWindowName  指定的log窗口
// *
// *  @return 是否删除成功
// */
//+ (BOOL)closeLogWindowName:(NSString *)logWindowName;
//
/////关闭所有log窗口
//+ (BOOL)closeAllLogWindow;

///清空测试窗口
+ (void)clear;

@end
