//
//  CJAppLastUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJRootViewControllerType) {
    CJRootViewControllerTypeNoneEverLaunch = 0, /**< 未曾启动 */
    CJRootViewControllerTypeGuide,
    CJRootViewControllerTypeLogin,
    CJRootViewControllerTypeMain,               /**< 登录成功以及游客直接跳过登录进入主页的 */
};


/**
 *  上一次退出前的APP信息
 */
@interface CJAppLastUtil : NSObject

#pragma mark - 1、在UserDefaults中保存用户信息--账号密码

///在UserDefaults中获取最后一次登录的账号（默认显示或者自动登录的时候有用）
+ (NSString *)getLastLoginAccount;



#pragma mark - 2、钥匙串操作
/**
 *  在Service和UserDefault中保存账号account以及其对应的密码password
 *
 *  @param account  要保存的账号
 *  @param password 要保存的账号的密码
 */
+ (void)saveAccount:(NSString *)account withPassword:(NSString *)password;

///钥匙串中是否保存该账号
+ (BOOL)isKeychainContainAccount:(NSString *)queryAccount;

///从钥匙串中获取指定账号的密码（如果该账号的密码有被保存，则返回该账号密码，如果该账号密码在钥匙串中被删了，或者钥匙串被删了，则返回空。）
+ (NSString *)getKeychainPasswordForAccount:(NSString *)queryAccount;

/**
 *  删除钥匙串中的指定账号的用户信息--账号和密码
 *
 *  @param account 要删除的账号
 */
+ (void)deleteAccountFromKeychain:(NSString *)account;












///保存App信息（已默认保存了 appVersion 和 appBuild）
+ (void)saveLastAppInfoWithRootViewControllerType:(CJRootViewControllerType)rootViewControllerType
                                      otherParams:(NSDictionary *)params;

///获取App信息（之前已默认保存了 appVersion 和 appBuild）
+ (NSDictionary *)getLastAppInfo;

/**
 *  获取上一次退出前的页面(区分版本的时候，如果是新版本则返回未启动)
 *
 *  @param distinctAppVersion   是否区分版本
 *
 *  @return 上一次退出前的页面
 */
+ (CJRootViewControllerType)getLastRootViewControllerTypeWithDistinctAppVersion:(BOOL)distinctAppVersion;

@end
