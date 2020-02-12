//
//  CQKitSetting.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQKitSetting.h"
#import "CJHUDSettingManager.h"
#import "CQRefreshSettingManager.h"

@interface CQKitSetting() {
    
}

@end



@implementation CQKitSetting

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
    CQRefreshSettingManager *refreshAnimateManager = [CQRefreshSettingManager sharedInstance];
    [refreshAnimateManager configHeaderAnimationWithAnimationNamed:animationNamed];
}

+ (void)updateHeaderStateTextWithIdleText:(NSString *)idleText
                              pullingText:(NSString *)pullingText
                           refreshingText:(NSString *)refreshingText
{
    CQRefreshSettingManager *refreshAnimateManager = [CQRefreshSettingManager sharedInstance];
    [refreshAnimateManager updateHeaderStateTextWithIdleText:idleText pullingText:pullingText refreshingText:refreshingText];
}

#pragma mark - FOOTER
+ (void)updateFooterStateTextWithIdleText:(NSString *)idleText
                              pullingText:(NSString *)pullingText
                           refreshingText:(NSString *)refreshingText
                           noMoreDataText:(NSString *)noMoreDataText
{
    CQRefreshSettingManager *refreshAnimateManager = [CQRefreshSettingManager sharedInstance];
    [refreshAnimateManager updateFooterStateTextWithIdleText:idleText pullingText:pullingText refreshingText:refreshingText noMoreDataText:noMoreDataText];
}


@end
