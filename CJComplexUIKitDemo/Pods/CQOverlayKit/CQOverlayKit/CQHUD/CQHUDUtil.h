//
//  CQHUDUtil.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  加载进度视图

#import <UIKit/UIKit.h>
#import "CQLoadingHUD.h"

@interface CQHUDUtil : NSObject {
    
}
#pragma mark - 使用时候调用
/// 显示ProgressHUD
+ (void)showLoadingHUD;

/// 隐藏ProgressHUD
+ (void)dismissLoadingHUD;


#pragma mark - 获取与全局动画一致的ProgressHUD对象
/**
 *  获取与全局动画一致的新的的ProgressHUD对象
 */
+ (CQLoadingHUD *)defaultLoadingHUD;



@end
