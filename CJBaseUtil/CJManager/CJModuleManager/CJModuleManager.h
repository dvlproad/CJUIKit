//
//  CJModuleManager.h
//  CJModuleManager
//
//  Created by ciyouzen on 2018/1/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  对[FRDModuleManager](https://github.com/lincode/FRDModuleManager)进行完善，并使其可以在podspec中使用

@import UIKit;
@import UserNotifications;

NS_ASSUME_NONNULL_BEGIN

@protocol CJModule <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@end


@interface CJModuleManager : NSObject<UIApplicationDelegate, UNUserNotificationCenterDelegate>

+ (instancetype)sharedInstance;

- (void)addModules:(NSArray<id<CJModule>> *)modules;
- (void)addModule:(id<CJModule>)module;

- (NSArray<id<CJModule>> *)allModules;

@end

NS_ASSUME_NONNULL_END
