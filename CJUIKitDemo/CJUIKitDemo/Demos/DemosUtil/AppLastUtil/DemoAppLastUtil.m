//
//  DemoAppLastUtil.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/10/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoAppLastUtil.h"

@implementation DemoAppLastUtil

///是否是第一次安装app
+ (BOOL)isFirstInstallApp {
    CJAppLastInfo *lastAppInfo = [CJAppLastInfoManager getLastAppInfo];
    return lastAppInfo.isFirstInstallApp;
}

///是否是第一次安装这个版本
+ (BOOL)isFirstInstallThisVersion {
    CJAppLastInfo *lastAppInfo = [CJAppLastInfoManager getLastAppInfo];
    return lastAppInfo.isFirstInstallThisVersion;
}

///点完了引导页更新状态
+ (void)readOverGuide {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"isReadOverGuide"];
    [userDefaults synchronize];
}

///是否点完了引导页
+ (BOOL)isReadOverGuide {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isReadOverGuide = [userDefaults objectForKey:@"isReadOverGuide"];
    return isReadOverGuide;
}



///获取最后登录的账号信息
+ (CJAppLastUser *)getLastLoginUser {
    return [CJAppLastUserManager getLastLoginUser];
}

@end
