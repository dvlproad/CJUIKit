//
//  CQAlertManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQAlertManager.h"
#import <CJOverlayView/CJMessageAlertView.h>
#import <CJBaseHelper/AuthorizationCJHelper.h>
#import "CQOverlayTheme.h"

#import "UIView+CQPopupOverlayAction.h"

@interface CQAlertManager () {
    
}
@property (nonatomic, strong) CJMessageAlertView *networkNoOpenAlert;      /**< 网络权限没打开的alert */
@property (nonatomic, strong) CJMessageAlertView *locationNoOpenAlert;     /**< 定位权限没打开的alert */
@property (nonatomic, strong) CJMessageAlertView *locationAbnormalAlert;   /**< 定位权限异常的alert */


@end



@implementation CQAlertManager

+ (CQAlertManager *)sharedInstance {
    static CQAlertManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

///显示拨打电话的弹窗
- (void)showPhoneAlertWithPhone:(NSString *)phone {
    NSString *alertCancelText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.alertCancelText;
    NSString *alertCallPhoneText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.alertCallPhoneText;
    
    __weak typeof(self)weakSelf = self;
    CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:nil title:phone message:nil cancelButtonTitle:alertCancelText okButtonTitle:alertCallPhoneText cancelHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
        NSLog(@"取消");
        [weakSelf __hideAlertView:bAlertView];
    } okHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
        NSLog(@"拨打电话");
        [weakSelf __hideAlertView:bAlertView];
    }];
    [self __showAlertView:alertView];
}

///显示和隐藏网络权限没打开的alert
- (void)showNetworkNoOpenAlert:(BOOL)show {
    if (!show) {
        if (self.networkNoOpenAlert) {
            [self __hideAlertView:self.networkNoOpenAlert];
            self.networkNoOpenAlert = nil;
        }
    } else {
        if (self.networkNoOpenAlert) {
            return;
        }
        NSString *networkNoOpenText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.networkNoOpenText;
        NSString *networkGoOpenText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.networkGoOpenText;
        __weak typeof(self)weakSelf = self;
        CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:nil title:networkNoOpenText message:nil okButtonTitle:networkGoOpenText okHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
            [weakSelf __hideAlertView:bAlertView];
            self.networkNoOpenAlert = nil;
            [AuthorizationCJHelper openSettingWithCompletionHandler:nil];
        }];
        self.networkNoOpenAlert = alertView;

        [self __showAlertView:self.networkNoOpenAlert];
    }
}

///显示和隐藏定位权限没打开的alert
- (void)showLocationNoOpenAlert:(BOOL)show {
    if (!show) {
        if (self.locationNoOpenAlert) {
            [self __hideAlertView:self.locationNoOpenAlert];
            self.locationNoOpenAlert = nil;
        }
    } else {
        [self showLocationAbnormalAlert:NO]; //隐藏定位权限异常的alert
        if (self.locationNoOpenAlert) {
            return;
        }
        NSString *locationNoOpenText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.locationNoOpenText;
        NSString *locationGoOpenText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.locationGoOpenText;
        __weak typeof(self)weakSelf = self;
        self.locationNoOpenAlert = [[CJMessageAlertView alloc] initWithFlagImage:nil title:locationNoOpenText message:nil okButtonTitle:locationGoOpenText okHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
            [weakSelf __hideAlertView:bAlertView];
            self.locationNoOpenAlert = nil;
            [AuthorizationCJHelper openSettingWithCompletionHandler:nil];
        }];

        [self __showAlertView:self.locationNoOpenAlert];
    }
}

///显示和隐藏定位权限异常的alert
- (void)showLocationAbnormalAlert:(BOOL)show {
    if (!show) {
        if (self.locationAbnormalAlert) {
            [self __hideAlertView:self.locationAbnormalAlert];
            self.locationAbnormalAlert = nil;
        }
    } else {
        [self showLocationNoOpenAlert:NO]; //隐藏定位权限没打开的alert
        if (self.locationAbnormalAlert) {
            return;
        }
        NSString *locationAbnormalText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.locationAbnormalText;
        NSString *alertIKonwText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.alertIKonwText;
        __weak typeof(self)weakSelf = self;
        self.locationAbnormalAlert = [[CJMessageAlertView alloc] initWithFlagImage:nil title:locationAbnormalText message:nil okButtonTitle:alertIKonwText okHandle:^(CJMessageAlertView * _Nonnull bAlertView) {
            [weakSelf __hideAlertView:bAlertView];
            self.locationAbnormalAlert = nil;
            [AuthorizationCJHelper openSettingWithCompletionHandler:nil];
        }];

        [self __showAlertView:self.locationAbnormalAlert];
    }
}

#pragma mark - Private Method
- (void)__showAlertView:(CJMessageAlertView *)alertView {
    CGSize popupViewSize = [alertView alertSizeWithShouldAutoFitHeight:YES];
    [alertView cqOverlay_alert_showWithSize:popupViewSize tapBlankShouldHide:YES];
}

- (void)__hideAlertView:(CJMessageAlertView *)alertView {
    [alertView cqOverlay_alert_hide];
}

@end
