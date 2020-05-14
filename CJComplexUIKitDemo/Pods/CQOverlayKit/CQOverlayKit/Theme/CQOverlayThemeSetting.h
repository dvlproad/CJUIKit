//
//  CQOverlayThemeSetting.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  此类内置一些主题风格，可用于直接使用，或者自己参考这边的设置来自定义自己的主题

#import <UIKit/UIKit.h>
// UI
#import "CJOverlayCommonThemeModel.h"
#import "CJOverlayAlertThemeModel.h"
#import "CQHUDThemeModel.h"
#import "CQToastThemeModel.h"

// 文本(主要处理国际化类型)
#import "CQOverlayTextModel.h"

typedef NS_ENUM(NSUInteger, OverlayThemeType) {
    OverlayThemeTypeDefault,
    OverlayThemeTypeCoffee,
    OverlayThemeTypeTea,
    OverlayThemeTypeEmployee
};


@interface CQOverlayThemeSetting : NSObject {
    
}

#pragma mark - Theme UI Setting
/// UI Toast
+ (CQToastThemeModel *)serviceUI_toastThemeModel;

/// UI HUD
+ (CQHUDThemeModel *)serviceUI_hudThemeModel;

#pragma mark - Theme Text Setting
/// 设置 全局默认 的 弹窗文本
+ (CQOverlayTextModel *)serviceText_allTextModel;

#pragma mark - Quick Use
/// 设置 全局默认 的 主题风格
+ (void)useThemeType:(OverlayThemeType)themeType;

@end
