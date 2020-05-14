//
//  CQOverlayThemeSetting.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQOverlayThemeSetting.h"

// overlay
#import <CQOverlayKit/CQOverlayTheme.h>

@implementation CQOverlayThemeSetting

#pragma mark - Theme UI Setting
/// UI common
+ (CJOverlayCommonThemeModel *)serviceUI_commonThemeModel {
    return [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel;
}

/// UI Toast
+ (CQToastThemeModel *)serviceUI_toastThemeModel {
    return [CJBaseOverlayThemeManager serviceThemeModel].toastThemeModel;
}

/// UI Alert
+ (CJAlertThemeModel *)serviceUI_alertThemeModel {
    return [CJBaseOverlayThemeManager serviceThemeModel].alertThemeModel;
}

/// UI HUD
+ (CQHUDThemeModel *)serviceUI_hudThemeModel {
    return [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel;
}


//+ (void)configHUDAnimationNamed:(NSString *)animationNamed {
//    CQHUDThemeModel *hudThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel;
//    hudThemeModel.animationNamed = animationNamed;
//}


//- (CQOverlayThemeSetting *(^)(NSString *animationNamed))configAnimationNamed {
//    return ^(NSString *animationNamed) {
//        CQHUDThemeModel *hudThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel;
//        hudThemeModel.animationNamed = animationNamed;
//
//        return self;
//    };
//}


#pragma mark - Theme Text Setting
/// 设置 全局默认 的 弹窗文本
+ (CQOverlayTextModel *)serviceText_allTextModel {
    return [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel;
}


/*
/// alert common
+ (void)overlayText_alertCommon_IKonwText:(NSString *)alertIKonwText
                               cancelText:(NSString *)alertCancelText
                                   okText:(NSString *)alertOKText
{
    [[self serviceText_allTextModel] updateText_alertCommon_IKonwText:alertIKonwText cancelText:alertCancelText okText:alertOKText];
}

/// alert callPhone
+ (void)overlayText_alertCallPhone_callPhoneText:(NSString *)callPhoneText
{
    CQOverlayTextModel *overlayTextModel = [self serviceText_allTextModel];
    overlayTextModel.alertCallPhoneText = callPhoneText;
}

/// alert network
+ (void)overlayText_alertNetwork_noOpenText:(NSString *)networkNoOpenText goOpenText:(NSString *)networkGoOpenText {
    CQOverlayTextModel *overlayTextModel = [self serviceText_allTextModel];
    overlayTextModel.networkNoOpenText = networkNoOpenText;
    overlayTextModel.networkGoOpenText = networkGoOpenText;
}

/// alert location
+ (void)overlayText_alertNetwork_noOpenText:(NSString *)locationNoOpenText
                                 goOpenText:(NSString *)locationGoOpenText
                               abnormalText:(NSString *)locationAbnormalText
{
    CQOverlayTextModel *overlayTextModel = [self serviceText_allTextModel];
    overlayTextModel.locationNoOpenText = locationNoOpenText;
    overlayTextModel.locationGoOpenText = locationGoOpenText;
    overlayTextModel.locationAbnormalText = locationAbnormalText;
}

/// sheet common
+ (void)overlayText_sheetCommon_cancelText:(NSString *)sheetCancelText {
    CQOverlayTextModel *overlayTextModel = [self serviceText_allTextModel];
    overlayTextModel.sheetCancelText = sheetCancelText;
}

/// sheet image choose
+ (void)overlayText_sheetImageChoose_takPhotoText:(NSString *)sheetTakPhotoText pickImageText:(NSString *)sheetPickImageText {
    CQOverlayTextModel *overlayTextModel = [self serviceText_allTextModel];
    overlayTextModel.sheetTakPhotoText = sheetTakPhotoText;
    overlayTextModel.sheetPickImageText = sheetPickImageText;
}

/// sheet map choose
+ (void)overlayText_sheetMapChoose_baiduMapText:(NSString *)sheetBaiduMapText
                                       amapText:(NSString *)sheetAmapText
                                   appleMapText:(NSString *)sheetAppleMapText
                               noInstallMapText:(NSString *)sheetNoInstallMapText
{
    CQOverlayTextModel *overlayTextModel = [self serviceText_allTextModel];
    overlayTextModel.sheetBaiduMapText = sheetBaiduMapText;
    overlayTextModel.sheetAmapText = sheetAmapText;
    overlayTextModel.sheetAppleMapText = sheetAppleMapText;
    overlayTextModel.sheetNoInstallMapText = sheetNoInstallMapText;
}
/*/


#pragma mark - Quick Use
/// 设置 全局默认 的 主题风格
+ (void)useThemeType:(OverlayThemeType)themeType {
    switch (themeType) {
        case OverlayThemeTypeCoffee:
        {
            [self _useThemeCoffee];
            break;
        }
        case OverlayThemeTypeTea:
        {
            [self _useThemeTea];
            break;
        }
        case OverlayThemeTypeEmployee:
        {
            [self _useThemeEmployee];
            break;
        }
        default:
        {
            break;
        }
    }
}


#pragma mark Theme Coffee
/// 设置 全局默认 的 主题 为 Coffee 主题
+ (void)_useThemeCoffee {
    // 设置 全局默认 的 进度加载
    CQHUDThemeModel *hudThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel;
    [hudThemeModel updateAnimationNamed:@"loading_coffee"
                        animationBundle:[CQHUDThemeModel currentHUDBundle]];
    
    
    // overlay
    CJBaseOverlayThemeModel *overlayThemeModel = [CJBaseOverlayThemeManager serviceThemeModel];
    // alert common
    overlayThemeModel.overlayTextModel.alertIKonwText = NSLocalizedString(@"我知道了2", nil);
    overlayThemeModel.overlayTextModel.alertCancelText = NSLocalizedString(@"取消", nil);
    overlayThemeModel.overlayTextModel.alertOKText = NSLocalizedString(@"确定", nil);
}


#pragma mark Theme Tea
/// 设置 全局默认 的 主题 为 Tea 主题
+ (void)_useThemeTea {
    // 设置 全局默认 的 进度加载
    CQHUDThemeModel *hudThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel;
    [hudThemeModel updateAnimationNamed:@"loading_tea"
                        animationBundle:[CQHUDThemeModel currentHUDBundle]];
}


#pragma mark Theme Employee
/// 设置 全局默认 的 主题 为 Employee 主题
+ (void)_useThemeEmployee {
    // 设置 全局默认 的 进度加载
    CQHUDThemeModel *hudThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].hudThemeModel;
    [hudThemeModel updateAnimationNamed:@"loading_coffee"
                        animationBundle:[CQHUDThemeModel currentHUDBundle]];
}


@end
