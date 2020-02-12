//
//  CQKitSetting.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQKitSetting.h"

#ifdef TEST_CJBASEUIKIT_POD
#import "CJThemeManager.h"
#import "CJHUDSettingManager.h"
#else
#import <CJBaseUIKit/CJThemeManager.h>
#import <CJBaseUIKit/CJHUDSettingManager.h>
#endif
#import <CJBaseEffectKit/CJRefreshJSONSettingManager.h>

@interface CQKitSetting() {
    
}

@end



@implementation CQKitSetting

#pragma mark - Theme
+ (void)configThemeWithThemeModel:(CJThemeModel *)themeModel {
    [CJThemeManager sharedInstance].serviceThemeModel = [CJThemeModel defaultThemeModel];
}


#pragma mark - HUD
/**
*  设置全局ProgressHUD的json文件名
*
*  @param animationNamed animationNamed
*/
+ (void)configHUDAnimationWithAnimationNamed:(NSString *)animationNamed {
    CJHUDSettingManager *hudSettingManager = [CJHUDSettingManager sharedInstance];
    [hudSettingManager configHUDAnimationWithAnimationNamed:animationNamed];
}


#pragma mark - HEADER
+ (void)configHeaderAnimationWithAnimationNamed:(NSString *)animationNamed {
    CJRefreshJSONSettingManager *refreshAnimateManager = [CJRefreshJSONSettingManager sharedInstance];
    [refreshAnimateManager configHeaderAnimationWithAnimationNamed:animationNamed];
}

+ (void)updateHeaderStateTextWithIdleText:(NSString *)idleText
                              pullingText:(NSString *)pullingText
                           refreshingText:(NSString *)refreshingText
{
    CJRefreshJSONSettingManager *refreshAnimateManager = [CJRefreshJSONSettingManager sharedInstance];
    [refreshAnimateManager updateHeaderStateTextWithIdleText:idleText pullingText:pullingText refreshingText:refreshingText];
}

#pragma mark - FOOTER
+ (void)updateFooterStateTextWithIdleText:(NSString *)idleText
                              pullingText:(NSString *)pullingText
                           refreshingText:(NSString *)refreshingText
                           noMoreDataText:(NSString *)noMoreDataText
{
    CJRefreshJSONSettingManager *refreshAnimateManager = [CJRefreshJSONSettingManager sharedInstance];
    [refreshAnimateManager updateFooterStateTextWithIdleText:idleText pullingText:pullingText refreshingText:refreshingText noMoreDataText:noMoreDataText];
}


@end
