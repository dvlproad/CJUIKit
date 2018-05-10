//
//  AppDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+WindowRootViewController.h"

#import <CJNetwork/CJNetworkMonitor.h>

#import "YunUncaughtExceptionHandler.h"
#import "CJAlertView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CJLog(@"测试环境写过log");
    CJAppLog(CJAppLogTypeDEBUG, @"0", @"测试环境写过log");
    
    YunInstallUncaughtExceptionHandler();
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //默认的设置，如网络监听等
        [[CJNetworkMonitor sharedInstance] startNetworkMonitoringWithReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                case AFNetworkReachabilityStatusNotReachable:
                {
                    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
                    CGSize popupViewSize = CGSizeMake(screenWidth * 0.7, 120);
                    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:15 secondVerticalInterval:10 thirdVerticalInterval:0];
                    [alertView addTitleWithText:NSLocalizedString(@"未连接网络", nil) font:[UIFont systemFontOfSize:15.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
                    [alertView addMessageWithText:NSLocalizedString(@"请检查WIFI或者数据是否开启", nil) font:[UIFont systemFontOfSize:14.0] textAlignment:NSTextAlignmentCenter margin:20 paragraphStyle:nil];
                    [alertView addBottomButtonWithHeight:40 cancelButtonTitle:nil okButtonTitle:NSLocalizedString(@"我知道了", nil) cancelHandle:nil okHandle:^{
                        NSLog(@"点击了断网确认按钮");
                    }];
                    [alertView showWithShouldFitHeight:YES];
                    break;
                }
                default:
                    break;
            }
        }];
    });
    
    
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [self getMainRootViewController];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //改变导航栏背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    //改变导航栏的字体
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont systemFontOfSize:21]}];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
