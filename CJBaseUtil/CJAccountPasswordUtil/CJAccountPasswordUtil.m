//
//  CJAccountPasswordUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAccountPasswordUtil.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString * const KCJAccountPasswordUtilServiceName = @"CJAccountPassword_preference";
//账号相关
static NSString * const KCJAccountPasswordUtilServiceLastLoginAccount = @"CJAccountPassword_p:user:lastestLogin";
//服务器信息
static NSString * const KCJAccountPasswordUtilServiceAddress = @"CJAccountPassword_p:server:address";
static NSString * const KCJAccountPasswordUtilServicePort = @"CJAccountPassword_p:server:port";


static NSString * const KCJAccountPasswordUtilSound = @"CJAccountPassword_p:sound";
static NSString * const KCJAccountPasswordUtilShake = @"CJAccountPassword_p:shake";
static NSString * const KCJAccountPasswordUtilDetailMsg = @"CJAccountPassword_p:detail-msg";
static NSString * const KCJAccountPasswordUtilNoHarass = @"CJAccountPassword_p:noharass";
static NSString * const  KCJAccountPasswordUtilBackgroundImageUrl = @"CJAccountPassword_p:bgimage";

@implementation CJAccountPasswordUtil

/**
 *  创建单例
 *
 *  @return 单例
 */
+ (CJAccountPasswordUtil *)sharedInstance {
    static CJAccountPasswordUtil *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        
        if (![_sharedInstance has:KCJAccountPasswordUtilSound])
            _sharedInstance.sound = YES;
        if (![_sharedInstance has:KCJAccountPasswordUtilShake])
            _sharedInstance.vibrate = YES;
        if (![_sharedInstance has:KCJAccountPasswordUtilDetailMsg])
            _sharedInstance.detailMsg = NO;
        if (![_sharedInstance has:KCJAccountPasswordUtilNoHarass])
            _sharedInstance.noDisturb = YES;
    });
    return _sharedInstance;
}


- (BOOL)has:(NSString*)key
{
    if (key.length == 0)
        return NO;
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return [NSStringFromClass([value class]) length] > 0;
}

#pragma mark - 1、在钥匙串中保存用户信息--账号密码
/* 完整的描述请参见文件头部 */
- (void)saveAccount:(NSString *)account withPassword:(NSString *)password {
    [SAMKeychain setPassword:password forService:KCJAccountPasswordUtilServiceName account:account];
    [self saveLastLoginAccount:account];
}

/**
 *  在UserDefaults中保存最后一次登录的账号（默认显示或者自动登录的时候有用）
 *
 *  @param account  要保存的账号
 */
- (void)saveLastLoginAccount:(NSString *)account {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:account forKey:KCJAccountPasswordUtilServiceLastLoginAccount];
    [userDefaults synchronize];
}


#pragma mark - 2、获取保存在钥匙串中的用户信息--账号和密码
- (NSString *)lastValidAccount {
    NSString *lastLoginAccount = [self getLastLoginAccount];
    return [self getValidAccountWithAccount:lastLoginAccount];
}

- (NSString *)lastValidPassword {
    NSString *lastValidAccount = [self lastValidAccount];
    return [self getValidPasswordWithAccount:lastValidAccount];
}

- (NSString *)getValidAccountWithAccount:(NSString *)queryAccount {
    NSArray *accounts = [SAMKeychain accountsForService:KCJAccountPasswordUtilServiceName];
    if ([[accounts valueForKey:kSAMKeychainAccountKey] containsObject:queryAccount]) {
        return queryAccount;
    } else {
        return nil;
    }
}

- (NSString *)getValidPasswordWithAccount:(NSString *)queryAccount {
    NSString *validAccount = [self getValidAccountWithAccount:queryAccount];
    if (validAccount.length == 0) {
        return nil;
    }
    NSString *validPassword = [SAMKeychain passwordForService:KCJAccountPasswordUtilServiceName account:validAccount];
    return validPassword;
}

/* 完整的描述请参见文件头部 */
- (NSDictionary *)getAccountInfoFromKeychainByLastLoginAccount {
    NSString *lastLoginAccount = [self getLastLoginAccount];
    
    return [self getAccountInfoFromKeychainByAccount:lastLoginAccount];
}

/**
 *  在UserDefaults中获取最后一次登录的账号（默认显示或者自动登录的时候有用）
 *
 */
- (NSString *)getLastLoginAccount {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults valueForKey:KCJAccountPasswordUtilServiceLastLoginAccount];
    
    return account;
}

/**
 *  从钥匙串中获取指定账号的账号信息--账号和密码
 *
 *  return 如果该账号有被保存，则返回该账号信息，如果该账号在钥匙串中被删了，或者钥匙串被删了，则返回空。
 */
- (NSDictionary *)getAccountInfoFromKeychainByAccount:(NSString *)queryAccount {
    NSArray *accounts = [SAMKeychain accountsForService:KCJAccountPasswordUtilServiceName];
    if ([[accounts valueForKey:kSAMKeychainAccountKey] containsObject:queryAccount]) {
        NSString *account = queryAccount;
        NSString *password = [SAMKeychain passwordForService:KCJAccountPasswordUtilServiceName account:account];
        NSDictionary *accountInfoDictionary = @{@"account": account,
                                                @"password":password,
                                                };
        return accountInfoDictionary;
    } else {
        return nil;
    }
}

#pragma mark - 3、删除钥匙串中的指定账号的用户信息--账号和密码
/* 完整的描述请参见文件头部 */
- (void)deleteAccountFromKeychain:(NSString *)account {
    if (account.length > 0) {
        [SAMKeychain deletePasswordForService:KCJAccountPasswordUtilServiceName account:account];
    }
}


















#pragma mark - 其他
- (void)setServerAddress:(NSString *)address port:(NSString *)port
{
    if (address.length == 0)
        return;
    [[NSUserDefaults standardUserDefaults] setValue:address forKey:KCJAccountPasswordUtilServiceAddress];
    [[NSUserDefaults standardUserDefaults] setValue:port forKey:KCJAccountPasswordUtilServicePort];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)serverAddress
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:KCJAccountPasswordUtilServiceAddress];
}

- (NSString *)serverPort
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:KCJAccountPasswordUtilServicePort];
}

- (BOOL)serverReady
{
    return [[self serverAddress] length] > 0 && [[self serverPort] length] > 0;
}

- (NSInteger)devenv
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"dev"] integerValue];
}

- (void)setDevenv:(NSInteger)enable
{
    [[NSUserDefaults standardUserDefaults] setValue:@(enable) forKey:@"dev"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"dev"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)sound
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:KCJAccountPasswordUtilSound] boolValue];
}
- (void)setSound:(BOOL)sound
{
    [[NSUserDefaults standardUserDefaults] setValue:@(sound) forKey:KCJAccountPasswordUtilSound];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)vibrate
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:KCJAccountPasswordUtilShake] boolValue];
}
- (void)setVibrate:(BOOL)vibrate
{
    [[NSUserDefaults standardUserDefaults] setValue:@(vibrate) forKey:KCJAccountPasswordUtilShake];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)detailMsg
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:KCJAccountPasswordUtilDetailMsg] boolValue];
}
- (void)setDetailMsg:(BOOL)detailMsg
{
    [[NSUserDefaults standardUserDefaults] setValue:@(detailMsg) forKey:KCJAccountPasswordUtilDetailMsg];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)noDisturb
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:KCJAccountPasswordUtilNoHarass] boolValue];
}
- (void)setNoDisturb:(BOOL)noDisturb
{
    [[NSUserDefaults standardUserDefaults] setValue:@(noDisturb) forKey:KCJAccountPasswordUtilNoHarass];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)backgroundImageUrl
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:KCJAccountPasswordUtilBackgroundImageUrl];
}
- (void)setBackgroundImageUrl:(NSString *)backgroundImageUrl
{
    [[NSUserDefaults standardUserDefaults] setValue:backgroundImageUrl forKey:KCJAccountPasswordUtilBackgroundImageUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)curSubjectId {
    NSNumber *number = [[NSUserDefaults standardUserDefaults] valueForKey:NSStringFromSelector(_cmd)];
    if (![number isKindOfClass:[NSNumber class]]) {
        return -1;
    }
    return [number integerValue];
}

- (void)setCurSubjectId:(NSInteger)curSubjectId {
    [[NSUserDefaults standardUserDefaults] setValue:@(curSubjectId) forKey:NSStringFromSelector(@selector(curSubjectId))];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
