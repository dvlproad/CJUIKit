//
//  CJAppLastUserManager.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJAppLastUser.h"

/**
 *  上一次退出前的APP账号信息
 */
@interface CJAppLastUserManager : NSObject {
    
}
/**
 *  在Service和UserDefault中保存账号account以及其对应的accessToken
 *
 *  @param account      account
 *  @param accessToken  accessToken
 */
+ (void)saveAccount:(NSString *)account withAccessToken:(NSString *)accessToken;


/**
 *  在UserDefaults中获取最后一次登录的账号（默认显示或者自动登录的时候有用）
 *
 *  @return 最后一次登录的账号信息
 */
+ (CJAppLastUser *)getLastLoginUser;


/**
 *  删除钥匙串中的指定账号的用户信息--账号和密码
 *
 *  @param account 要删除的账号
 */
+ (void)deleteAccountFromKeychain:(NSString *)account;

@end
