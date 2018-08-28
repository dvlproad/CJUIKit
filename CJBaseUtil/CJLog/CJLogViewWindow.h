//
//  CJLogViewWindow.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

/**
 *  一个在 iOS 设备屏幕上实时打印 Log 的小工具(使用单例，保证其子视图LogView被持续强制持有，而不会因某个时刻被释放，而导致切换到其他页面后，之前的log被清空)
 */
@interface CJLogViewWindow : UIWindow


+ (void)show:(BOOL)show;

/**
 *  将appendObject追加写入视图
 *
 *  @param appendObject     要追加写入视图的数据（NSData、NSString、NSDictrionary、NSArray）
 */
+ (void)appendObject:(id)appendObject;

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
