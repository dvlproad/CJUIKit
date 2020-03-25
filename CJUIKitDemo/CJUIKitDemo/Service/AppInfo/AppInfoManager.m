//
//  AppInfoManager.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/19.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "AppInfoManager.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "TSAlertManager.h"


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
        self->_lastNetworkReachabilityStatus = status;
        
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
        [[TSAlertManager sharedInstance] showNetworkNoOpenAlert:YES];
    } else {
        [[TSAlertManager sharedInstance] showNetworkNoOpenAlert:NO];
        [defaultCenter postNotificationName:@"NetworkEnableChange" object:nil];
    }
}

@end
