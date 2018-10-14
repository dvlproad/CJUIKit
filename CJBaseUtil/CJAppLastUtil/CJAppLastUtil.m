//
//  CJAppLastUtil.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/10/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJAppLastUtil.h"

@implementation CJAppLastUtil

#pragma mark - LastLaunchInfo
///是否是第一次安装app
+ (BOOL)isFirstLaunchApp {
    CJAppLastLaunchInfo *lastLaunchInfo = [CJAppLastLaunchInfoManager getLastLaunchInfo];
    return lastLaunchInfo.isFirstLaunchApp;
}

///是否是第一次安装这个版本
+ (BOOL)isFirstLaunchThisVersion {
    CJAppLastLaunchInfo *lastLaunchInfo = [CJAppLastLaunchInfoManager getLastLaunchInfo];
    return lastLaunchInfo.isFirstLaunchThisVersion;
}

#pragma mark - Guide
/* 完整的描述请参见文件头部 */
+ (BOOL)isReadOverGuideWithDistinctAppVersion:(BOOL)distinctAppVersion  {
    NSString *lastReadOverGuideVersion = [self lastReadOverGuideVersion];
    
    if (!distinctAppVersion) {
        return lastReadOverGuideVersion ? YES : NO;
    } else {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *currentAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        BOOL isUpperVersion = [currentAppVersion compare:lastReadOverGuideVersion options:NSNumericSearch] == NSOrderedDescending;//当前版本高于上次版本
        return isUpperVersion ? YES : NO;
    }
}

///上一次点完引导页后的Version
+ (NSString *)lastReadOverGuideVersion {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *readOverGuideVersion = [userDefaults objectForKey:@"cjReadOverGuideVersion"];
    return readOverGuideVersion;
}

///上一次点完引导页后的Build
+ (NSString *)lastReadOverGuideBulid {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *readOverGuideBuild = [userDefaults objectForKey:@"cjReadOverGuideBuild"];
    return readOverGuideBuild;
}

/* 完整的描述请参见文件头部 */
+ (void)readOverGuide {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //其他信息的保存
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    [userDefaults setObject:appVersion forKey:@"cjReadOverGuideVersion"];   //点完引导页后的Version
    [userDefaults setObject:appBuild forKey:@"cjReadOverGuideBuild"];       //点完引导页后的Build
    
    [userDefaults synchronize];
}


#pragma mark - User
+ (void)saveAccount:(NSString *)account withAccessToken:(NSString *)accessToken {
    [CJAppLastUserManager saveAccount:account withAccessToken:accessToken];
}

+ (CJAppLastUser *)getLastLoginUser {
    return [CJAppLastUserManager getLastLoginUser];
}

+ (void)deleteAccountFromKeychain:(NSString *)account {
    [CJAppLastUserManager deleteAccountFromKeychain:account];
}

@end
