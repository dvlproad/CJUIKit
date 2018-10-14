//
//  CJAppLastUserManager.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAppLastUserManager.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString * const kCJKeychainServiceName = @"cj_keychainServiceName";
//账号相关
static NSString * const kCJLastLoginAccount = @"cj_lastLoginAccount";


@implementation CJAppLastUserManager

/* 完整的描述请参见文件头部 */
+ (void)saveAccount:(NSString *)account withAccessToken:(NSString *)accessToken {
    [SAMKeychain setPassword:accessToken forService:kCJKeychainServiceName account:account];
    
    //在UserDefaults中保存最后一次登录的账号（默认显示或者自动登录的时候有用）
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:account forKey:kCJLastLoginAccount];
    [userDefaults synchronize];
}

/* 完整的描述请参见文件头部 */
+ (CJAppLastUser *)getLastLoginUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults valueForKey:kCJLastLoginAccount];
    
    NSString *accessToken = [self getKeychainAccessTokenForAccount:userName];
    
    CJAppLastUser *user = [[CJAppLastUser alloc] init];
    user.lastLoginUserName = userName;
    user.lastLoginAccessToken = accessToken;
    
    return user;
}

///从钥匙串中获取指定账号的密码（如果该账号的密码有被保存，则返回该账号密码，如果该账号密码在钥匙串中被删了，或者钥匙串被删了，则返回空。）
+ (NSString *)getKeychainAccessTokenForAccount:(NSString *)queryAccount {
    BOOL isContain = [self isKeychainContainAccount:queryAccount];
    if (!isContain) {
        return nil;
    }
    NSString *keychainPassword = [SAMKeychain passwordForService:kCJKeychainServiceName account:queryAccount];
    return keychainPassword;
}

///钥匙串中是否保存该账号
+ (BOOL)isKeychainContainAccount:(NSString *)queryAccount {
    NSArray *accounts = [SAMKeychain accountsForService:kCJKeychainServiceName];
    BOOL isContain = [[accounts valueForKey:kSAMKeychainAccountKey] containsObject:queryAccount];
    return isContain;
}



/* 完整的描述请参见文件头部 */
+ (void)deleteAccountFromKeychain:(NSString *)account {
    if (account.length > 0) {
        [SAMKeychain deletePasswordForService:kCJKeychainServiceName account:account];
    }
}

@end
