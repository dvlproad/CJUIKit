//
//  TSAlertManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TSAlertManager.h"
#import <CJBaseOverlayKit/CJMessageAlertView.h>
#import <CJBaseHelper/AuthorizationCJHelper.h>

#import "CJBaseAlertView+TSPopupAction.h"

@interface TSAlertManager () {
    
}
@property (nonatomic, strong) CJMessageAlertView *networkNoOpenAlert;      /**< 网络权限没打开的alert */
@property (nonatomic, strong) CJMessageAlertView *locationNoOpenAlert;     /**< 定位权限没打开的alert */
@property (nonatomic, strong) CJMessageAlertView *locationAbnormalAlert;   /**< 定位权限异常的alert */


@end



@implementation TSAlertManager

+ (TSAlertManager *)sharedInstance {
    static TSAlertManager *_sharedInstance = nil;
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

///显示和隐藏网络权限没打开的alert
- (void)showNetworkNoOpenAlert:(BOOL)show {
    if (!show) {
        if (self.networkNoOpenAlert) {
            [self.networkNoOpenAlert dismiss];
            self.networkNoOpenAlert = nil;
        }
    } else {
        if (self.networkNoOpenAlert) {
            return;
        }
        NSString *networkNoOpenText = NSLocalizedString(@"网络链接失败，请检查您的网络链接", nil);
        NSString *networkGoOpenText = NSLocalizedString(@"查看设置", nil);
        CJMessageAlertView *alertView = [[CJMessageAlertView alloc] initWithFlagImage:nil title:networkNoOpenText message:nil okButtonTitle:networkGoOpenText okHandle:^{
            self.networkNoOpenAlert = nil;
            [AuthorizationCJHelper openSettingWithCompletionHandler:nil];
        }];
        self.networkNoOpenAlert = alertView;
        
        [self __showAlertView:self.networkNoOpenAlert];
    }
}


#pragma mark - Private Method
- (void)__showAlertView:(CJMessageAlertView *)alertView {
    [alertView showWithShouldFitHeight:YES];
}


@end
