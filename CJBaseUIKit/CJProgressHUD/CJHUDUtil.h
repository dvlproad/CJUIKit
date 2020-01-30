//
//  CJHUDUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  加载进度视图

#import <UIKit/UIKit.h>
#import "CJProgressHUD.h"

@interface CJHUDUtil : NSObject {
    
}

#pragma mark - 全局设置(APP启动时候调用)
/**
 *  设置全局ProgressHUD的json文件名
 *
 *  @param animationNamed animationNamed
 */
+ (void)updateAnimationNamed:(NSString *)animationNamed;


#pragma mark - 使用时候调用
/// 显示ProgressHUD
+ (void)show;

/// 隐藏ProgressHUD
+ (void)dismiss;


#pragma mark - 获取与全局动画一致的ProgressHUD
/**
 *  获取与全局动画一致的默认的ProgressHUD
 */
+ (CJProgressHUD *)defaultProgressHUD;



@end
