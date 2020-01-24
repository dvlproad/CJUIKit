//
//  CQAlertManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQAlertManager.h"
#import "CJMessageAlertView.h"

#ifdef TEST_CJBASEHELPER_POD
#import "AuthorizationCJHelper.h"
#else
#import <CJBaseHelper/AuthorizationCJHelper.h>
#endif

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
    CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:nil title:phone message:nil cancelButtonTitle:NSLocalizedString(@"取消", nil) okButtonTitle:NSLocalizedString(@"拨打", nil) cancelHandle:^{
        NSLog(@"取消");
    } okHandle:^{
        NSLog(@"拨打");
    }];
    [self __showAlertView:alertView];
}

///显示和隐藏网络权限没打开的alert
- (void)showNetworkNoOpenAlert:(BOOL)show {
    if (!show) {
        if (self.networkNoOpenAlert) {
            [self.networkNoOpenAlert dismissWithDelay:0];
            self.networkNoOpenAlert = nil;
        }
    } else {
        if (self.networkNoOpenAlert) {
            return;
        }
        CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:nil title:NSLocalizedString(@"网络链接失败，请检查您的网络链接", nil) message:nil okButtonTitle:NSLocalizedString(@"查看设置", nil) okHandle:^{
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
            [self.locationNoOpenAlert dismissWithDelay:0];
            self.locationNoOpenAlert = nil;
        }
    } else {
        [self showLocationAbnormalAlert:NO]; //隐藏定位权限异常的alert
        if (self.locationNoOpenAlert) {
            return;
        }
        self.locationNoOpenAlert = [[CJMessageAlertView alloc] initWithFlagImage:nil title:NSLocalizedString(@"您没开启GPS，无法接单", nil) message:nil okButtonTitle:NSLocalizedString(@"去开启", nil) okHandle:^{
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
            [self.locationAbnormalAlert dismissWithDelay:0];
            self.locationAbnormalAlert = nil;
        }
    } else {
        [self showLocationNoOpenAlert:NO]; //隐藏定位权限没打开的alert
        if (self.locationAbnormalAlert) {
            return;
        }
        self.locationAbnormalAlert = [[CJMessageAlertView alloc] initWithFlagImage:nil title:NSLocalizedString(@"获取定位权限异常，请手动授权APP定位权限", nil) message:nil okButtonTitle:NSLocalizedString(@"我知道了", nil) okHandle:^{
            self.locationAbnormalAlert = nil;
            [AuthorizationCJHelper openSettingWithCompletionHandler:nil];
        }];
        
        [self __showAlertView:self.locationAbnormalAlert];
    }
}

#pragma mark - Private Method
- (void)__showAlertView:(CJMessageAlertView *)alertView {
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
//    UIColor *blankBGColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    [alertView showWithShouldFitHeight:YES blankBGColor:blankBGColor];
}


@end
