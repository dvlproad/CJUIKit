//
//  CQHUDUtil.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQHUDUtil.h"
#import "CQOverlayTheme.h"
#import <CJBaseOverlayKit/UIWindow+CJShareLoadingHUD.h>

@interface CQHUDUtil () {
    
}

@end


@implementation CQHUDUtil

#pragma mark - 使用时候调用
+ (void)showLoadingHUD {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (keyWindow.cjShareProgressHUD) {
        return;
    }
    CQLoadingHUD *shareHud = [CQHUDUtil sharedProgressHUD];
    [shareHud play];
    [keyWindow cj_addShareProgressHUD:shareHud showingStateOperateEnable:NO];
}

+ (void)dismissLoadingHUD {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (keyWindow.cjShareProgressHUD) {
        [(CQLoadingHUD *)keyWindow.cjShareProgressHUD stop];
        [keyWindow cj_removeShareProgressHUD];
    }
}


+ (CQLoadingHUD *)sharedProgressHUD {
    static CQLoadingHUD *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *animationNamed = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel.animationNamed;
        NSBundle *animationBundle = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel.animationBundle;
        _sharedInstance = [[CQLoadingHUD alloc] initWithAnimationNamed:animationNamed inBundle:animationBundle];
    });
    return _sharedInstance;
}


#pragma mark - 获取与全局动画一致的ProgressHUD对象
/**
 *  获取与全局动画一致的新的的ProgressHUD对象
 */
+ (CQLoadingHUD *)defaultLoadingHUD {
    NSString *animationNamed = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel.animationNamed;
    NSBundle *animationBundle = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel.animationBundle;
    return [[CQLoadingHUD alloc] initWithAnimationNamed:animationNamed inBundle:animationBundle];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
