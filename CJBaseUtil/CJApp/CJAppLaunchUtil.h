//
//  CJAppLaunchUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJRootViewControllerType) {
    CJRootViewControllerTypeNoneEverLaunch = 0, /**< 未曾启动东 */
    CJRootViewControllerTypeGuide,
    CJRootViewControllerTypeLogin,
    CJRootViewControllerTypeMain,               /**< 登录成功以及游客直接跳过登录进入主页的 */
};



@interface CJAppLaunchUtil : NSObject

+ (instancetype)sharedInstance;

//#pragma mark - 启动版本是否最新的检查(不同于安装版本是否最新的检查)
///**
// *  检验当前版本是否是最新的启动版本
// */
//- (BOOL)checkCurrentAppVersionIsNewAppVersion;
//
///**
// *  保存当前的版本作为最后启动的app版本
// */
//- (void)saveCurrentAppVersionAsLastLaunchAppVersion;


/**
 *  是否已经启动过（不区分用户，只要在这台手机上曾启动过计算）
 *
 *  @param distinctAppVersion   是否区分版本
 *  reurn 是否已经启动过
 */
- (BOOL)checkHaveEverLaunchedByDistinctAppVersion:(BOOL)distinctAppVersion;

/**
 *  设置当前保存为已经启动过(在启动一次之后将启动状态设为YES)
 *
 *  @param distinctAppVersion   是否区分版本
 */
- (void)changeToHaveLaunchByDistinctAppVersion:(BOOL)distinctAppVersion;


#pragma mark - 上一次退出前的页面 LastRootViewController
///保存上一次退出前的页面
- (void)saveLastRootViewControllerType:(CJRootViewControllerType)rootViewControllerType;

///获取上一次退出前的页面
- (CJRootViewControllerType)lastRootViewControllerType;


#pragma mark - 启动相关
///是否允许游客进入app主页
- (BOOL)allowVisitorEnterIntoAppMainViewController;


///设置是否允许自动登录(登录成功后，可以进行设置为YES，但是退出登录后，一定要将此值设置为NO)
- (void)setAutoLogin:(BOOL)enable;
- (BOOL)canAutoLogin;


@end
