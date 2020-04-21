//
//  CQOverlayTextModel.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

// Overlay文本(主要处理国际化类型)
@interface CQOverlayTextModel : NSObject {
    
}
// alert common
@property (nonatomic, copy) NSString *alertIKonwText;       // NSLocalizedString(@"我知道了", nil)
@property (nonatomic, copy) NSString *alertCancelText;      // NSLocalizedString(@"取消", nil)
@property (nonatomic, copy) NSString *alertOKText;          // NSLocalizedString(@"确定", nil)
// alert callPhone
@property (nonatomic, copy) NSString *alertCallPhoneText;   // NSLocalizedString(@"拨打", nil)
// alert network
@property (nonatomic, copy) NSString *networkNoOpenText;    // NSLocalizedString(@"网络链接失败，请检查您的网络链接", nil)
@property (nonatomic, copy) NSString *networkGoOpenText;    // NSLocalizedString(@"查看设置", nil)
// alert location
@property (nonatomic, copy) NSString *locationNoOpenText;    // NSLocalizedString(@"您没开启GPS，无法接单", nil)
@property (nonatomic, copy) NSString *locationGoOpenText;    // NSLocalizedString(@"去开启", nil)
@property (nonatomic, copy) NSString *locationAbnormalText;  // NSLocalizedString(@"获取定位权限异常，请手动授权APP定位权限", nil)


// sheet common
@property (nonatomic, copy) NSString *sheetCancelText;      // NSLocalizedString(@"取消", nil)
// sheet image choose
@property (nonatomic, copy) NSString *sheetTakPhotoText;    // NSLocalizedString(@"拍摄", nil)
@property (nonatomic, copy) NSString *sheetPickImageText;   // NSLocalizedString(@"从手机相册选择", nil)
// sheet map choose
@property (nonatomic, copy) NSString *sheetBaiduMapText;    // NSLocalizedString(@"百度地图", nil)
@property (nonatomic, copy) NSString *sheetAmapText;        // NSLocalizedString(@"高德地图", nil)
@property (nonatomic, copy) NSString *sheetAppleMapText;    // NSLocalizedString(@"苹果地图", nil)
@property (nonatomic, copy) NSString *sheetNoInstallMapText;// NSLocalizedString(@"未安装", nil)

/*
#pragma mark - Theme Text Update
/// alert common
- (void)updateText_alertCommon_IKonwText:(NSString *)alertIKonwText
                              cancelText:(NSString *)alertCancelText
                                  okText:(NSString *)alertOKText;

/// alert callPhone
- (void)updateText_alertCallPhone_callPhoneText:(NSString *)callPhoneText;

/// alert network
- (void)updateText_alertNetwork_noOpenText:(NSString *)networkNoOpenText goOpenText:(NSString *)networkGoOpenText;

/// alert location
- (void)updateText_alertNetwork_noOpenText:(NSString *)locationNoOpenText
                                goOpenText:(NSString *)locationGoOpenText
                              abnormalText:(NSString *)locationAbnormalText;

/// sheet common
- (void)updateText_sheetCommon_cancelText:(NSString *)sheetCancelText;

/// sheet image choose
- (void)updateText_sheetImageChoose_takPhotoText:(NSString *)sheetTakPhotoText pickImageText:(NSString *)sheetPickImageText;

/// sheet map choose
- (void)updateText_sheetMapChoose_baiduMapText:(NSString *)sheetBaiduMapText
                                      amapText:(NSString *)sheetAmapText
                                  appleMapText:(NSString *)sheetAppleMapText
                              noInstallMapText:(NSString *)sheetNoInstallMapText;
/*/

@end



