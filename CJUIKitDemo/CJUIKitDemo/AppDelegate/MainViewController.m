//
//  MainViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MainViewController.h"

#import "HomeViewController.h"
#import "FoundationHomeViewController.h"
#import "UtilHomeViewController.h"
#import "HelperHomeViewController.h"
#import "MoreHomeViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_BG"];
    
    /*
    知识点(UITabBarController):
    ①设置标题tabBarItem.title：为了使得tabBarItem中的title可以和显示在顶部的navigationItem的title保持各自，分别设置.tabBarItem.title和.navigationItem的title的值
    ②设置图片tabBarItem.image：会默认去掉图片的颜色，如果要看到原图片，需要设置图片的渲染模式为UIImageRenderingModeAlwaysOriginal
    ③设置角标tabBarItem.badgeValue：如果没有设置图片，角标默认显示在左上角，设置了图片就会在图片的右上角显示
    */
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    homeViewController.view.backgroundColor = [UIColor whiteColor];
    homeViewController.navigationItem.title = NSLocalizedString(@"CJBaseUIKit首页", nil);
    homeViewController.tabBarItem.title = NSLocalizedString(@"CJBaseUIKit", nil);
    homeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //homeViewController. = @"10";
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    [self addChildViewController:homeNavigationController];
    
    FoundationHomeViewController *foundationHomeViewController = [[FoundationHomeViewController alloc] init];
    foundationHomeViewController.view.backgroundColor = [UIColor whiteColor];
    foundationHomeViewController.navigationItem.title = NSLocalizedString(@"Foundation首页", nil);
    foundationHomeViewController.tabBarItem.title = NSLocalizedString(@"CJFoundataion", nil);
    foundationHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *foundationHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:foundationHomeViewController];
    [self addChildViewController:foundationHomeNavigationController];
    
    HelperHomeViewController *helperHomeViewController = [[HelperHomeViewController alloc] init];
    helperHomeViewController.view.backgroundColor = [UIColor whiteColor];
    helperHomeViewController.navigationItem.title = NSLocalizedString(@"CJHelper首页", nil);
    helperHomeViewController.tabBarItem.title = NSLocalizedString(@"CJHelper", nil);
    helperHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *helperHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:helperHomeViewController];
    [self addChildViewController:helperHomeNavigationController];
    
    UtilHomeViewController *utilHomeViewController = [[UtilHomeViewController alloc] init];
    utilHomeViewController.view.backgroundColor = [UIColor whiteColor];
    utilHomeViewController.navigationItem.title = NSLocalizedString(@"Util首页", nil);
    utilHomeViewController.tabBarItem.title = NSLocalizedString(@"CJUtil", nil);
    utilHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *utilHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:utilHomeViewController];
    [self addChildViewController:utilHomeNavigationController];
    
    MoreHomeViewController *moreHomeViewController = [[MoreHomeViewController alloc] init];
    moreHomeViewController.view.backgroundColor = [UIColor whiteColor];
    moreHomeViewController.navigationItem.title = NSLocalizedString(@"更多", nil);
    moreHomeViewController.tabBarItem.title = NSLocalizedString(@"更多", nil);
    moreHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *moreHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:moreHomeViewController];
    [self addChildViewController:moreHomeNavigationController];
    
    /*
    UIViewController *secondViewController = [[ThirdPartyHomeViewController alloc] init];
    secondViewController.view.backgroundColor = [UIColor whiteColor];
    secondViewController.navigationItem.title = NSLocalizedString(@"第三方库", nil);
    secondViewController.tabBarItem.title = NSLocalizedString(@"第三方库首页", nil);
    secondViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    [self addChildViewController:secondNavigationController];
    */
//    [self setViewControllers:@[firstNavigationController, secondNavigationController, navigationController3, navigationController4] animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
