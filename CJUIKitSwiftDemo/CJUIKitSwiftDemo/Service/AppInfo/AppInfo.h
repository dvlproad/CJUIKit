//
//  AppInfo.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/29.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject {
    
}

/**
 应用版本号，取自 Info.plist 的 CFBundleShortVersionString 值

 @return NSString
 */
+ (NSString *)systemAppVersion;

/**
 本app专用应用版本号，四位数字，去除小数点
 
 @return NSString
 */
+ (NSString *)demoAppVersion;


@end
