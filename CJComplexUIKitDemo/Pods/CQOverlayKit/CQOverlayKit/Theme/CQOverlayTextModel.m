//
//  CQOverlayTextModel.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQOverlayTextModel.h"

@implementation CQOverlayTextModel

- (instancetype)init {
    self = [super init];
    if (self) {
        // Overlay文本(主要处理国际化类型)
        
        // alert common
        _alertIKonwText = NSLocalizedString(@"我知道了", nil);
        _alertCancelText = NSLocalizedString(@"取消", nil);
        _alertOKText = NSLocalizedString(@"确定", nil);
        // alert callPhone
        _alertCallPhoneText = NSLocalizedString(@"拨打", nil);
        // alert network
        _networkNoOpenText = NSLocalizedString(@"网络链接失败，请检查您的网络链接", nil);
        _networkGoOpenText = NSLocalizedString(@"查看设置", nil);
        // alert location
        _locationNoOpenText = NSLocalizedString(@"您没开启GPS，无法接单", nil);
        _locationGoOpenText = NSLocalizedString(@"去开启", nil);
        _locationAbnormalText = NSLocalizedString(@"获取定位权限异常，请手动授权APP定位权限", nil);
        
        // sheet common
        _sheetCancelText = NSLocalizedString(@"取消", nil);
        // sheet image choose
        _sheetTakPhotoText = NSLocalizedString(@"拍摄", nil);
        _sheetPickImageText = NSLocalizedString(@"从手机相册选择", nil);
        // sheet map choose
        _sheetBaiduMapText = NSLocalizedString(@"百度地图", nil);
        _sheetAmapText = NSLocalizedString(@"高德地图", nil);
        _sheetAppleMapText = NSLocalizedString(@"苹果地图", nil);
        _sheetNoInstallMapText = NSLocalizedString(@"未安装", nil);
    }
    return self;
}


/*
#pragma mark - Theme Text Update
/// alert common
- (void)updateText_alertCommon_IKonwText:(NSString *)alertIKonwText
                              cancelText:(NSString *)alertCancelText
                                  okText:(NSString *)alertOKText
{
    _alertIKonwText = alertIKonwText;
    _alertCancelText = alertCancelText;
    _alertOKText = alertOKText;
}

/// alert callPhone
- (void)updateText_alertCallPhone_callPhoneText:(NSString *)callPhoneText
{
    _alertCallPhoneText = callPhoneText;
}

/// alert network
- (void)updateText_alertNetwork_noOpenText:(NSString *)networkNoOpenText goOpenText:(NSString *)networkGoOpenText {
    _networkNoOpenText = networkNoOpenText;
    _networkGoOpenText = networkGoOpenText;
}

/// alert location
- (void)updateText_alertNetwork_noOpenText:(NSString *)locationNoOpenText
                                goOpenText:(NSString *)locationGoOpenText
                              abnormalText:(NSString *)locationAbnormalText
{
    _locationNoOpenText = locationNoOpenText;
    _locationGoOpenText = locationGoOpenText;
    _locationAbnormalText = locationAbnormalText;
}

/// sheet common
- (void)updateText_sheetCommon_cancelText:(NSString *)sheetCancelText {
    _sheetCancelText = sheetCancelText;
}

/// sheet image choose
- (void)updateText_sheetImageChoose_takPhotoText:(NSString *)sheetTakPhotoText pickImageText:(NSString *)sheetPickImageText {
    _sheetTakPhotoText = sheetTakPhotoText;
    _sheetPickImageText = sheetPickImageText;
}

/// sheet map choose
- (void)updateText_sheetMapChoose_baiduMapText:(NSString *)sheetBaiduMapText
                                      amapText:(NSString *)sheetAmapText
                                  appleMapText:(NSString *)sheetAppleMapText
                              noInstallMapText:(NSString *)sheetNoInstallMapText
{
    _sheetBaiduMapText = sheetBaiduMapText;
    _sheetAmapText = sheetAmapText;
    _sheetAppleMapText = sheetAppleMapText;
    _sheetNoInstallMapText = sheetNoInstallMapText;
}
/*/

@end
