//
//  AppInfoManager.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/12/19.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import "AppInfo.h"

/**
 *  appInfo管理类(包含存储网络状态）
 */
@interface AppInfoManager : NSObject {
    
}
@property (nonatomic, assign, readonly) BOOL networkEnable; /**< 网络是否可达（WWAN和WiFi为YES） */
@property (nonatomic, strong) AppInfo *serviceAppInfo;    /**< 服务的app */

+ (AppInfoManager *)sharedInstance;

#pragma mark - 网络监听
- (void)startNetworkMonitoring; ///开启网络监听


@end
