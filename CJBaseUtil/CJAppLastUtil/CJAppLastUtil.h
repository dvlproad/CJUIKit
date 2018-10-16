//
//  CJAppLastUtil.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/10/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJAppLastLaunchInfoManager.h"
#import "CJAppLastUserManager.h"

@interface CJAppLastUtil : NSObject

#pragma mark - LastLaunchInfo
///是否是第一次安装app
+ (BOOL)isFirstLaunchApp;

///是否是第一次安装这个版本
+ (BOOL)isFirstLaunchThisVersion;


#pragma mark - Guide
/**
 *  是否点完了引导页
 *
 *  @param distinctAppVersion   是否区分版本
 *
 *  @return 是否点完了引导页
 */
+ (BOOL)isReadOverGuideWithDistinctAppVersion:(BOOL)distinctAppVersion;

///点完了引导页更新状态
+ (void)readOverGuide;


#pragma mark - User
///保存account和accessToken
+ (void)saveAccount:(NSString *)account withAccessToken:(NSString *)accessToken;

///获取最后登录的账号信息
+ (CJAppLastUser *)getLastLoginUser;

///删除钥匙串中的指定账号的用户信息
+ (void)deleteAccountFromKeychain:(NSString *)account;

@end
