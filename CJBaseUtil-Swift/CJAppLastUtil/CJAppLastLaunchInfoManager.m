//
//  CJAppLastLaunchInfoManager.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAppLastLaunchInfoManager.h"

@implementation CJAppLastLaunchInfoManager

/* 完整的描述请参见文件头部 */
+ (CJAppLastLaunchInfo *)getLastLaunchInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"cj_lastLaunchInfo"];
    CJAppLastLaunchInfo *appInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (appInfo == nil) { //第一次安装
        appInfo = [[CJAppLastLaunchInfo alloc] init];
        appInfo.lastAppVersion = nil;
        appInfo.lastAppBuild = nil;
    }
    
    [self updateLastLaunchInfo];
    
    return appInfo;
}

/* 完整的描述请参见文件头部 */
+ (void)updateLastLaunchInfo {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    CJAppLastLaunchInfo *lastLaunchInfo = [[CJAppLastLaunchInfo alloc] init];
    lastLaunchInfo.lastAppVersion = appVersion;
    lastLaunchInfo.lastAppBuild = appBuild;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data  = [NSKeyedArchiver archivedDataWithRootObject:lastLaunchInfo];
    [userDefaults setObject:data forKey:@"cj_lastLaunchInfo"];
    [userDefaults synchronize];
}


@end
