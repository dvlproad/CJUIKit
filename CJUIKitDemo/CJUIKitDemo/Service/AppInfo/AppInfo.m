//
//  AppInfo.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/29.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

+ (NSString *)systemAppVersion {
    static NSString *appVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    });
    return appVersion;
}

+ (NSString *)demoAppVersion {
    static NSString *demoAppVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *appVersion = [self systemAppVersion];
        appVersion = [appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (appVersion.length == 2) {
            appVersion = [appVersion stringByAppendingString:@"00"];
        } else if (appVersion.length == 3) {
            appVersion = [appVersion stringByAppendingString:@"0"];
        }
        demoAppVersion = appVersion;
    });
    return demoAppVersion;
}

@end
