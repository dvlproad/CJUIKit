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
+ (void)saveLastAppInfoWithRootViewControllerType:(CJRootViewControllerType)rootViewControllerType
                                      otherParams:(NSDictionary *)params
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    [mutableDictionary setObject:appVersion forKey:@"cj_lastAppVersion"];
    [mutableDictionary setObject:appBuild forKey:@"cj_lastAppBuild"];
    [mutableDictionary setObject:@(rootViewControllerType) forKey:@"cj_lastAppRootViewControllerType"];
    if (params) {
        [mutableDictionary addEntriesFromDictionary:params];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:mutableDictionary forKey:@"cj_lastAppInfo"];
}

/* 完整的描述请参见文件头部 */
+ (NSDictionary *)getLastAppInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *lastAppInfo = [userDefaults objectForKey:@"cj_lastAppInfo"];
    
    return lastAppInfo;
}


/* 完整的描述请参见文件头部 */
+ (CJRootViewControllerType)getLastRootViewControllerTypeWithDistinctAppVersion:(BOOL)distinctAppVersion {
    NSDictionary *lastAppInfo = [self getLastAppInfo];
    
    if (distinctAppVersion) {
        NSString *lastAppVersion = [lastAppInfo objectForKey:@"cj_lastAppVersion"];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *currentAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        if ([currentAppVersion compare:lastAppVersion options:NSNumericSearch] == NSOrderedDescending) { //当前版本高于上次版本
            return CJRootViewControllerTypeNoneEverLaunch;
        }
    }
    
    CJRootViewControllerType rootViewControllerType = [[lastAppInfo objectForKey:@"cj_lastAppRootViewControllerType"] integerValue];
    return rootViewControllerType;
}

@end
