//
//  UIWindow+RootSetting.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/12.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "UIWindow+RootSetting.h"
#import "MainViewController.h"
//#import "TSListDemo-Swift.h"
#import "ImageChangeColorViewController.h"

@implementation UIWindow (RootSetting)

- (void)settingRoot {
    [self setBackgroundColor:[UIColor whiteColor]];
    // 只直接测试某个页面
//    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"TSLayoutPriorityViewController") alloc] init]];
    UIViewController *rootViewController = [[ImageChangeColorViewController alloc] init];
    
    self.rootViewController = rootViewController;
    [self makeKeyAndVisible];
}

@end
