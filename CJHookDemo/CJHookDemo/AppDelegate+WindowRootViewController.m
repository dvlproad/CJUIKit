//
//  AppDelegate+WindowRootViewController.m
//  CJHookDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AppDelegate+WindowRootViewController.h"

#import "HookVCHomeViewController.h"
#import "HookCJHelperHomeViewController.h"

@implementation AppDelegate (WindowRootViewController)

- (UIViewController *)getMainRootViewController {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_BG"];
    
    /*
    知识点(UITabBarController):
    ①设置标题tabBarItem.title：为了使得tabBarItem中的title可以和显示在顶部的navigationItem的title保持各自，分别设置.tabBarItem.title和.navigationItem的title的值
    ②设置图片tabBarItem.image：会默认去掉图片的颜色，如果要看到原图片，需要设置图片的渲染模式为UIImageRenderingModeAlwaysOriginal
    ③设置角标tabBarItem.badgeValue：如果没有设置图片，角标默认显示在左上角，设置了图片就会在图片的右上角显示
    */
    HookCJHelperHomeViewController *homeViewController = [[HookCJHelperHomeViewController alloc] init];
    homeViewController.tabBarItem.title = NSLocalizedString(@"HookCJHelper", nil);
    homeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //homeViewController. = @"10";
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    [tabBarController addChildViewController:homeNavigationController];
    
    
    HookVCHomeViewController *tableViewHomeViewController = [[HookVCHomeViewController alloc] init];
    tableViewHomeViewController.tabBarItem.title = NSLocalizedString(@"Table", nil);
    tableViewHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *tableViewHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:tableViewHomeViewController];
    [tabBarController addChildViewController:tableViewHomeNavigationController];
    
    HookVCHomeViewController *collectionViewHomeViewController = [[HookVCHomeViewController alloc] init];
    collectionViewHomeViewController.tabBarItem.title = NSLocalizedString(@"Collection", nil);
    collectionViewHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *collectionViewHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:collectionViewHomeViewController];
    [tabBarController addChildViewController:collectionViewHomeNavigationController];
    
    HookVCHomeViewController *scrollViewHomeViewController = [[HookVCHomeViewController alloc] init];
    scrollViewHomeViewController.tabBarItem.title = NSLocalizedString(@"Web", nil);
    scrollViewHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *scrollViewHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:scrollViewHomeViewController];
    [tabBarController addChildViewController:scrollViewHomeNavigationController];
    
    /*
    OtherHomeViewController *viewController4 = [[OtherHomeViewController alloc] init];
    viewController4.view.backgroundColor = [UIColor whiteColor];
    viewController4.navigationItem.title = NSLocalizedString(@"基础小视图首页", nil);
    viewController4.tabBarItem.title = NSLocalizedString(@"基础小视图", nil);
    viewController4.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navigationController4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    [tabBarController addChildViewController:navigationController4];
    
    UIViewController *secondViewController = [[ThirdPartyHomeViewController alloc] init];
    secondViewController.view.backgroundColor = [UIColor whiteColor];
    secondViewController.navigationItem.title = NSLocalizedString(@"第三方库", nil);
    secondViewController.tabBarItem.title = NSLocalizedString(@"第三方库首页", nil);
    secondViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    [tabBarController addChildViewController:secondNavigationController];
    */
//    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController, navigationController3, navigationController4] animated:YES];
    
    return tabBarController;
}

@end
