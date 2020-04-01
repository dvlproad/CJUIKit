//
//  APPUIKitSetting.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "APPUIKitSetting.h"

//#import <LuckinBaseOverlayKit/CJHUDSettingManager.h>
#import <LuckinBaseEffectKit/CJRefreshJSONSettingManager.h>


@implementation APPUIKitSetting

/// 设置所有UIKit的主题
+ (void)configAppThemeUIKit {
    [self _configHUD];      // 设置 全局默认 的 加载
    [self _configRefresh];  // 设置 全局默认 的 下拉刷新 和 上拉加载
}

#pragma mark - HUD
/// 设置 全局默认 的 加载
+ (void)_configHUD {
//    CJHUDSettingManager *hudSettingManager = [CJHUDSettingManager sharedInstance];
//    [hudSettingManager configHUDAnimationWithAnimationNamed:@"loading_tea"];
}


#pragma mark - Refersh
/// 设置 全局默认 的 下拉刷新 和 上拉加载
+ (void)_configRefresh {
    CJRefreshJSONSettingManager *refreshAnimateManager = [CJRefreshJSONSettingManager sharedInstance];
    
    // HEADER
    [refreshAnimateManager configHeaderAnimationWithAnimationNamed:@"loading_coffee"];
    [refreshAnimateManager updateHeaderStateTextWithIdleText:NSLocalizedString(@"下拉刷新1", nil)
                                                 pullingText:NSLocalizedString(@"松开刷新2", nil)
                                              refreshingText:NSLocalizedString(@"加载数据中3", nil)];
    // FOOTER
    [refreshAnimateManager updateFooterStateTextWithIdleText:NSLocalizedString(@"上拉加载更多4", nil)
                                                 pullingText:NSLocalizedString(@"释放加载5", nil)
                                              refreshingText:NSLocalizedString(@"加载中6...", nil)
                                              noMoreDataText:NSLocalizedString(@"没有更多数据了7...", nil)];
}


@end
