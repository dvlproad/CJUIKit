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

/**
 *  存储网络状态的类
 */
@interface AppInfoManager : NSObject

@property (nonatomic, assign, readonly) BOOL networkEnable; /**< 网络是否可达（WWAN和WiFi为YES） */


+ (AppInfoManager *)sharedInstance;


#pragma mark - UIViewController
- (UIViewController *)getHomeViewController;
- (UIViewController *)getTopViewController;


#pragma mark - 网络监听
- (void)startNetworkMonitoring; ///开启网络监听


@end
