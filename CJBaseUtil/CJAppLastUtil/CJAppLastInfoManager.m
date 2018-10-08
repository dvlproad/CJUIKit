//
//  CJAppLastInfoManager.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAppLastInfoManager.h"

@implementation CJAppLastInfoManager

/* 完整的描述请参见文件头部 */
+ (CJAppLastInfo *)getLastAppInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"cj_lastAppInfo"];
    CJAppLastInfo *appInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (appInfo == nil) { //第一次安装
        appInfo = [[CJAppLastInfo alloc] init];
        appInfo.lastAppVersion = nil;
        appInfo.lastAppBuild = nil;
        appInfo.otherUserInfo = nil;
    }
    
    [self updateLastAppInfoWithOtherUserInfo:appInfo.otherUserInfo];
    
    return appInfo;
}

/* 完整的描述请参见文件头部 */
+ (void)updateLastAppInfoWithOtherUserInfo:(NSDictionary *)otherUserInfo {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    CJAppLastInfo *lastAppInfo = [[CJAppLastInfo alloc] init];
    lastAppInfo.lastAppVersion = appVersion;
    lastAppInfo.lastAppBuild = appBuild;
    lastAppInfo.otherUserInfo = otherUserInfo;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data  = [NSKeyedArchiver archivedDataWithRootObject:lastAppInfo];
    [userDefaults setObject:data forKey:@"cj_lastAppInfo"];
    [userDefaults synchronize];
}


@end
