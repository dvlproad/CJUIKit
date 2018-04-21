//
//  CJAppLaunchUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAppLaunchUtil.h"

static NSString *KCJAPPKeyAutoLogin = @"CJAPP_auto-login";
static NSString *KCJAPPKeyFirstRun = @"CJAPP_first-run";

static NSString *kCJAppKeyCurrentVersionHaveEverLaunched = @"CJApp_currentVersionHaveEverLaunched"; //当前版本是否启动过

@implementation CJAppLaunchUtil

/**
 *  创建单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance {
    static CJAppLaunchUtil *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

///**
// *  检验当前版本是否是最新的启动版本
// */
//- (BOOL)checkCurrentAppVersionIsNewAppVersion {
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *lastLaunchAppVersion = [userDefaults objectForKey:kLastLaunchAppVersionKey];
//
//    BOOL currentAppVersionIsNew = lastLaunchAppVersion == nil || [currentAppVersion compare:lastLaunchAppVersion options:NSNumericSearch] == NSOrderedDescending;
//
//    return currentAppVersionIsNew;
//}
//
///**
// *  保存当前的版本作为最后启动的app版本
// */
//- (void)saveCurrentAppVersionAsLastLaunchAppVersion {
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:currentAppVersion forKey:kLastLaunchAppVersionKey];
//}


/**
 *  是否已经启动过（不区分用户，只要在这台手机上曾启动过计算）
 *
 *  @param distinctAppVersion   是否区分版本
 *  reurn 是否已经启动过
 */
- (BOOL)checkHaveEverLaunchedByDistinctAppVersion:(BOOL)distinctAppVersion {
    NSString *haveEverLaunchedKey = @"";
    if (distinctAppVersion) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *currentAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        haveEverLaunchedKey = [NSString stringWithFormat:@"%@_%@", currentAppVersion, kCJAppKeyCurrentVersionHaveEverLaunched];
    } else {
        haveEverLaunchedKey = [NSString stringWithFormat:@"%@", kCJAppKeyCurrentVersionHaveEverLaunched];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL haveEverLaunched = [[userDefaults objectForKey:haveEverLaunchedKey] boolValue];
    return haveEverLaunched;
}

/**
 *  设置当前保存为已经启动过(在启动一次之后将启动状态设为YES)
 *
 *  @param distinctAppVersion   是否区分版本
 */
- (void)changeToHaveLaunchByDistinctAppVersion:(BOOL)distinctAppVersion {
    NSString *haveEverLaunchedKey = [NSString stringWithFormat:@"%@", kCJAppKeyCurrentVersionHaveEverLaunched];
    
    if (distinctAppVersion) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *currentAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        haveEverLaunchedKey = [NSString stringWithFormat:@"%@_%@", haveEverLaunchedKey, currentAppVersion];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(YES) forKey:haveEverLaunchedKey];
}


#pragma mark - 上一次退出前的页面 LastRootViewController
///保存上一次退出前的页面
- (void)saveLastRootViewControllerType:(CJRootViewControllerType)rootViewControllerType {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(rootViewControllerType) forKey:@"cjLastRootViewControllerType"];
}

///获取上一次退出前的页面
- (CJRootViewControllerType)lastRootViewControllerType {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CJRootViewControllerType rootViewControllerType = [[userDefaults objectForKey:@"cjLastRootViewControllerType"] integerValue];
    return rootViewControllerType;
}






#pragma mark - 启动相关
///是否允许游客进入app主页
- (BOOL)allowVisitorEnterIntoAppMainViewController {
    //BOOL allowVisitor = [[[NSUserDefaults standardUserDefaults] valueForKey:KCJAccountPasswordUtilKeyAllowVisitor] boolValue];
    BOOL allowVisitor = NO;
    return allowVisitor;
}



///设置是否允许自动登录(登录成功后，可以进行设置为YES，但是退出登录后，一定要将此值设置为NO)
- (void)setAutoLogin:(BOOL)enable
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@(enable) forKey:KCJAPPKeyAutoLogin];
    [userDefaults synchronize];
}

- (BOOL)canAutoLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL autoLogin = [[userDefaults valueForKey:KCJAPPKeyAutoLogin] boolValue];
    return autoLogin;
}




@end
