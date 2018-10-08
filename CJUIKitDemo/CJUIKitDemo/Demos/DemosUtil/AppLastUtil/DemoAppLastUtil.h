//
//  DemoAppLastUtil.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/10/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef CJTESTPOD
#import "CJAppLastInfoManager.h"
#import "CJAppLastUserManager.h"
#else
#import <CJBaseUtil/CJAppLastInfoManager.h>
#import <CJBaseUtil/CJAppLastUserManager.h>
#endif

@interface DemoAppLastUtil : NSObject

///是否是第一次安装app
+ (BOOL)isFirstInstallApp;

///是否是第一次安装这个版本
+ (BOOL)isFirstInstallThisVersion;

///点完了引导页更新状态
+ (void)readOverGuide;

///是否点完了引导页
+ (BOOL)isReadOverGuide;

///获取最后登录的账号信息
+ (CJAppLastUser *)getLastLoginUser;

@end
