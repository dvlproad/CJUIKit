//
//  UIWindow+RootSetting.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/12.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "UIWindow+RootSetting.h"
#import "MainViewController.h"
#import <TSDemo_DataVientiane/TSDataVientianeMainViewController.h>

@implementation UIWindow (RootSetting)

- (void)settingRoot {
    [self setBackgroundColor:[UIColor whiteColor]];
    // 只直接测试某个页面
//    UIViewController *rootViewController = [[TSDataVientianeMainViewController alloc] init];  // 数据万象
//    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"NSCalendarCJHelperViewController") alloc] init]]; // 数据万象里的日历加减
    
    // 数据排序、搜索、分组等的测试
//    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"TSDataModelUtilViewController") alloc] init]];
    
    UIViewController *rootViewController = [[MainViewController alloc] init];
    
    self.rootViewController = rootViewController;
    [self makeKeyAndVisible];
}

@end
