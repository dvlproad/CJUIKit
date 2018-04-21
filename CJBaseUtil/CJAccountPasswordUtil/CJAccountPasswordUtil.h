//
//  CJAccountPasswordUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  个人偏好设置
 */
@interface CJAccountPasswordUtil : NSObject

+ (instancetype)sharedInstance;



#pragma mark - 1、在钥匙串中保存用户信息--账号密码
/**
 *  在Service和UserDefault中保存账号account以及其对应的密码password
 *
 *  @param account  要保存的账号
 *  @param password 要保存的账号的密码
 */
- (void)saveAccount:(NSString *)account withPassword:(NSString *)password;


#pragma mark - 2、获取保存在钥匙串中的用户信息--账号和密码
///**
// *  从钥匙串中获取最后登录的账号的账号信息--账号和密码
// *
// *  return 如果该账号有被保存，则返回该账号信息，如果该账号在钥匙串中被删了，或者钥匙串被删了，则返回空。
// */
//- (NSDictionary *)getAccountInfoFromKeychainByLastLoginAccount;
- (NSString *)lastValidAccount;
- (NSString *)lastValidPassword;

- (NSString *)getValidAccountWithAccount:(NSString *)queryAccount;
- (NSString *)getValidPasswordWithAccount:(NSString *)queryAccount;


#pragma mark - 3、删除钥匙串中的指定账号的用户信息--账号和密码
/**
 *  在Service中删除之前保存过的某个账号
 *
 *  @param account 要删除的账号
 */
- (void)deleteAccountFromKeychain:(NSString *)account;


- (void)setServerAddress:(NSString*)address port:(NSString*)port;
- (NSString*)serverAddress;
- (NSString*)serverPort;

- (BOOL)serverReady;
- (NSInteger)devenv;
- (void)setDevenv:(NSInteger)enable;// 0:production 1:dev_production  2:dev_dev

//增加属性，使得可以直接通过属性获得对应值
@property (nonatomic, copy) NSString *backgroundImageUrl;
@property (nonatomic, assign) BOOL sound;
@property (nonatomic, assign) BOOL vibrate;
@property (nonatomic, assign) BOOL detailMsg;
@property (nonatomic, assign) BOOL noDisturb;
@property (nonatomic, assign) NSInteger curSubjectId;

@end
