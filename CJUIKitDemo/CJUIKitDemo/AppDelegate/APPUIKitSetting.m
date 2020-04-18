//
//  APPUIKitSetting.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "APPUIKitSetting.h"

//#import <CJBaseOverlayKit/CJHUDSettingManager.h>


@implementation APPUIKitSetting

/// 设置所有UIKit的主题
+ (void)configAppThemeUIKit {
    [self _configHUD];      // 设置 全局默认 的 加载
}

#pragma mark - HUD
/// 设置 全局默认 的 加载
+ (void)_configHUD {
//    CJHUDSettingManager *hudSettingManager = [CJHUDSettingManager sharedInstance];
//    [hudSettingManager configHUDAnimationWithAnimationNamed:@"loading_tea"];
}



@end
