//
//  AppInfoCJHelper.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppInfoCJHelper : NSObject {
    
}

/// 版本原始表示(应用版本号，取自 Info.plist 的 CFBundleShortVersionString 值)
+ (NSString *)appVersionOrigin;

/// 版本固定四位数来表示
+ (NSString *)appVersionFour;

/// 版本固定五位数来表示
+ (NSString *)appVersionFive;

@end
