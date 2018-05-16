//
//  AppInfoManager.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/19.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "AppInfoManager.h"
#import <SystemConfiguration/CaptiveNetwork.h>

#import "LoginViewController.h"


@interface AppInfoManager ()

@property (readonly, nonatomic, assign) AFNetworkReachabilityStatus lastNetworkReachabilityStatus;

@end


@implementation AppInfoManager

+ (AppInfoManager *)sharedInstance {
    static AppInfoManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - UIViewController
- (UIViewController *)getHomeViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *homeViewController = ((UINavigationController *)rootViewController).viewControllers[0];
        return homeViewController;
    } else {
        UIViewController *homeViewController = rootViewController;
        
        return homeViewController;
    }
}

- (UIViewController *)getTopViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *topViewController = ((UINavigationController *)rootViewController).topViewController;
        return topViewController;
        
    } else {
        UIViewController *topViewController = rootViewController;
        return topViewController;
    }
}


#pragma mark - 网络监听
/** 完整的描述请参见文件头部 */
- (void)startNetworkMonitoring {
    //AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager manager];//错误
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    __weak typeof(self)weakSelf = self;
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (weakSelf.lastNetworkReachabilityStatus == status) {
            return;
        }
        _lastNetworkReachabilityStatus = status;
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"未识别的网络");
                [self networkChange:NO];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"不可达的网络(未连接)");
                [self networkChange:NO];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"2G,3G,4G...的网络");
                [self networkChange:YES];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"wifi的网络");
                [self networkChange:YES];
                break;
            }
            default:
            {
                break;
            }
        }
    }];
    
    [reachabilityManager startMonitoring];
}


- (void)networkChange:(BOOL)currentNetworkEnable {
    _networkEnable = currentNetworkEnable;
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    if (!currentNetworkEnable) {
        UIViewController *topViewController = [self getTopViewController];
        if (![topViewController isKindOfClass:[LoginViewController class]]) {
            [self showNoNetworkAlert];
        } else {
            [defaultCenter postNotificationName:@"NetworkEnableChange" object:nil];
        }
    } else {
        [defaultCenter postNotificationName:@"NetworkEnableChange" object:nil];
    }
}

- (void)showNoNetworkAlert {
    /*
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 120);
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:15 secondVerticalInterval:10 thirdVerticalInterval:0];
    [alertView addTitleWithText:NSLocalizedString(@"未连接网络", nil) font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
    [alertView addMessageWithText:NSLocalizedString(@"请检查WIFI或者数据是否开启", nil) font:[UIFont systemFontOfSize:14.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
    [alertView addBottomButtonWithHeight:40 cancelButtonTitle:nil okButtonTitle:NSLocalizedString(@"我知道了", nil) cancelHandle:nil okHandle:^{
        NSLog(@"点击了断网确认按钮");
    }];
    [alertView showWithShouldFitHeight:NO];
    //*/
}

@end
