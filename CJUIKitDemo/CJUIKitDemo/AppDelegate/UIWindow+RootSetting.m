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

@implementation UIWindow (RootSetting)

- (void)settingRoot {
    [self setBackgroundColor:[UIColor whiteColor]];
    // 只直接测试某个页面
    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"KeyboardAutoMoveUpViewController") alloc] init]];
//    UIViewController *rootViewController = [[MainViewController alloc] init];
    
    self.rootViewController = rootViewController;
    [self makeKeyAndVisible];
}

@end
