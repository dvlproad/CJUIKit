//
//  AppInfoCJHelper.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AppInfoCJHelper.h"

@implementation AppInfoCJHelper

/// 版本原始表示
+ (NSString *)appVersionOrigin {
    static NSString *appVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    });
    return appVersion;
}

/// 版本固定四位数来表示
+ (NSString *)appVersionFour {
    static NSString *luckinAppVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *appVersion = [self appVersionOrigin];
        appVersion = [appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (appVersion.length == 2) {
            appVersion = [appVersion stringByAppendingString:@"00"];
        } else if (appVersion.length == 3) {
            appVersion = [appVersion stringByAppendingString:@"0"];
        }
        luckinAppVersion = appVersion;
    });
    return luckinAppVersion;
}

/// 版本固定五位数来表示
+ (NSString *)appVersionFive {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSArray *array = [app_Version componentsSeparatedByString:@"."];
    NSInteger innV = 1;
    if (array.count == 2) {
        NSInteger fir = [array[0] integerValue] * 10000;
        NSInteger sec = [array[1] integerValue] * 100;
        innV = fir + sec;
    } else if (array.count == 3) {
        NSInteger fir = [array[0] integerValue] * 10000;
        NSInteger sec = [array[1] integerValue] * 100;
        NSInteger thr = [array[2] integerValue] ;
        innV = fir + sec + thr;
    }
    
    NSString *version = [NSString stringWithFormat:@"%ld", innV];
    return version;
}

@end
