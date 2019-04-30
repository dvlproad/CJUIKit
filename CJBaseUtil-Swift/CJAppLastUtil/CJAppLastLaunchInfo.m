//
//  CJAppLastLaunchInfo.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/29.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJAppLastLaunchInfo.h"

@implementation CJAppLastLaunchInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.lastAppVersion = [aDecoder decodeObjectForKey:@"lastAppVersion"];
        self.lastAppBuild = [aDecoder decodeObjectForKey:@"lastAppBuild"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.lastAppVersion forKey:@"lastAppVersion"];
    [aCoder encodeObject:self.lastAppBuild forKey:@"lastAppBuild"];
}


///是否是第一次安装app
- (BOOL)isFirstLaunchApp {
    NSString *lastAppVersion = self.lastAppVersion;
    if (lastAppVersion == nil) {
        return YES;
    } else {
        return NO;
    }
}

///是否是第一次安装这个版本
- (BOOL)isFirstLaunchThisVersion {
    NSString *lastAppVersion = self.lastAppVersion;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    BOOL isUpperVersion = [currentAppVersion compare:lastAppVersion options:NSNumericSearch] == NSOrderedDescending;//当前版本高于上次版本
    if (isUpperVersion) {
        return YES;
    } else {
        return NO;
    }
    
    
}
@end
