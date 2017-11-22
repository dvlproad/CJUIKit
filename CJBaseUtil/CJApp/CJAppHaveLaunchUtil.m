//
//  CJAppHaveLaunchUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAppHaveLaunchUtil.h"

static NSString *kAPPHaveLaunchKey = @"APPHaveLaunchKey";
static NSString *kAPPVersionKey = @"APPVersionKey";

@implementation CJAppHaveLaunchUtil

/**
 *  创建单例
 *
 *  @return 单例
 */
+ (CJAppHaveLaunchUtil *)sharedInstance {
    static CJAppHaveLaunchUtil *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

/** 完整的描述请参见文件头部 */
- (BOOL)isAPPHaveLaunch {
    NSString *oldAppVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kAPPVersionKey];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *curAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    BOOL isAPPHaveLaunch;
    if (oldAppVersion == nil || [curAppVersion compare:oldAppVersion options:NSNumericSearch] == NSOrderedDescending) {
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:kAPPHaveLaunchKey];
        isAPPHaveLaunch = NO;
    } else {
        isAPPHaveLaunch = [[[NSUserDefaults standardUserDefaults] objectForKey:kAPPHaveLaunchKey] boolValue];
    }
    
    return isAPPHaveLaunch;
}

/** 完整的描述请参见文件头部 */
- (void)setAPPHaveLaunchStateYES {
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:kAPPHaveLaunchKey];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *curAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:curAppVersion forKey:kAPPVersionKey];
    
}


@end
