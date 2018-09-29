//
//  CJAppLastUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAppLastUtil.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString * const kCJKeychainServiceName = @"cj_keychainServiceName";
//账号相关
static NSString * const kCJLastLoginAccount = @"cj_lastLoginAccount";


@implementation CJAppLastUtil

#pragma mark - 1、在UserDefaults中保存用户信息--账号密码
/**
 *  在UserDefaults中保存最后一次登录的账号（默认显示或者自动登录的时候有用）
 *
 *  @param account  要保存的账号
 */
+ (void)saveLastLoginAccount:(NSString *)account {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:account forKey:kCJLastLoginAccount];
    [userDefaults synchronize];
}

/* 完整的描述请参见文件头部 */
+ (NSString *)getLastLoginAccount {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults valueForKey:kCJLastLoginAccount];
    
    return account;
}

#pragma mark - 2、钥匙串操作
/* 完整的描述请参见文件头部 */
+ (void)saveAccount:(NSString *)account withPassword:(NSString *)password {
    [SAMKeychain setPassword:password forService:kCJKeychainServiceName account:account];
    [self saveLastLoginAccount:account];
}

/* 完整的描述请参见文件头部 */
+ (BOOL)isKeychainContainAccount:(NSString *)queryAccount {
    NSArray *accounts = [SAMKeychain accountsForService:kCJKeychainServiceName];
    BOOL isContain = [[accounts valueForKey:kSAMKeychainAccountKey] containsObject:queryAccount];
    return isContain;
}

/* 完整的描述请参见文件头部 */
+ (NSString *)getKeychainPasswordForAccount:(NSString *)queryAccount {
    BOOL isContain = [self isKeychainContainAccount:queryAccount];
    if (!isContain) {
        return nil;
    }
    NSString *keychainPassword = [SAMKeychain passwordForService:kCJKeychainServiceName account:queryAccount];
    return keychainPassword;
}

/* 完整的描述请参见文件头部 */
+ (void)deleteAccountFromKeychain:(NSString *)account {
    if (account.length > 0) {
        [SAMKeychain deletePasswordForService:kCJKeychainServiceName account:account];
    }
}







/* 完整的描述请参见文件头部 */
+ (void)updateLastAppInfoWithRootViewControllerType:(CJRootViewControllerType)rootViewControllerType
                                      otherUserInfo:(NSDictionary *)otherUserInfo;
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    CJAppInfo *lastAppInfo = [[CJAppInfo alloc] init];
    lastAppInfo.lastAppVersion = appVersion;
    lastAppInfo.lastAppBuild = appBuild;
    lastAppInfo.lastAppRootViewControllerType = rootViewControllerType;
    lastAppInfo.otherUserInfo = otherUserInfo;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data  = [NSKeyedArchiver archivedDataWithRootObject:lastAppInfo];
    [userDefaults setObject:data forKey:@"cj_lastAppInfo"];
    [userDefaults synchronize];
}

/* 完整的描述请参见文件头部 */
+ (CJAppInfo *)getLastAppInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"cj_lastAppInfo"];
    CJAppInfo *appInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (appInfo == nil) { //第一次安装
        appInfo = [[CJAppInfo alloc] init];
        appInfo.lastAppVersion = nil;
        appInfo.lastAppBuild = nil;
        appInfo.lastAppRootViewControllerType = CJRootViewControllerTypeNoneEverLaunch;
        appInfo.otherUserInfo = nil;
    }
    [self updateLastAppInfoWithRootViewControllerType:appInfo.lastAppRootViewControllerType
                                        otherUserInfo:appInfo.otherUserInfo];
    
    return appInfo;
}

///是否是第一次安装app
+ (BOOL)isFirstInstallApp {
    CJAppInfo *lastAppInfo = [self getLastAppInfo];
    return lastAppInfo.isFirstInstallApp;
}

///是否是第一次安装这个版本
+ (BOOL)isFirstInstallThisVersion {
    CJAppInfo *lastAppInfo = [self getLastAppInfo];
    return lastAppInfo.isFirstInstallThisVersion;
}

/* 完整的描述请参见文件头部 */
+ (CJRootViewControllerType)getLastRootViewControllerTypeWithDistinctAppVersion:(BOOL)distinctAppVersion {
    CJAppInfo *lastAppInfo = [self getLastAppInfo];
    
    if (distinctAppVersion) {
        if (lastAppInfo.isFirstInstallThisVersion) {
            return CJRootViewControllerTypeNoneEverLaunch;
        }
    }
    
    CJRootViewControllerType rootViewControllerType = lastAppInfo.lastAppRootViewControllerType;
    return rootViewControllerType;
}

@end
