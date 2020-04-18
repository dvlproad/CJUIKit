//
//  AppDelegate.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+WindowRootViewController.h"

#import "YunUncaughtExceptionHandler.h"

#import "CJAppLastUtil.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

#import <UINavigation-SXFixSpace/UINavigationSXFixSpace.h>

#import <CJFoundation/NSString+CJCut.h>
#import <CJFoundation/NSString+CJAttributedString.h>

#import "APPUIKitSetting.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSInteger i = -1000;
    NSString *iString = [[NSString alloc] initWithFormat:@"%zd", i];
    NSLog(@"iString = %@", iString);
    
    
//    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor redColor]];
//    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    
    NSDictionary *dic = @{@"pushType": @(304),
                          @"msg": @"员工姓名 您好！您的 健康证 将于3天后，即2019-05-01 到期，为避免因证件到期，导致不能排班，请及时办理新的证件，并在员工APP进行提交更新。XXX感谢有你！"
                          };
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *dicString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"dicString = %@", dicString);
    
    NSString *title =  @"还差{{2}}件商品参与抽奖";
    CJStringAttributedModel *stringAttributedModel = [[CJStringAttributedModel alloc] init];
    stringAttributedModel.font = [UIFont systemFontOfSize:23];
    stringAttributedModel.color = CJColorFromHexString(@"#212474");
    stringAttributedModel.underline = NO;
    NSAttributedString *attributedTitle = [title attributedStringForSepicalBetweenStart:@"{{" end:@"}}" middleStringAttributedModel:stringAttributedModel];
    
    YunInstallUncaughtExceptionHandler();
    
    // 设置所有UIKit的主题
    [APPUIKitSetting configAppThemeUIKit];
    
    //[[IQKeyboardManager sharedManager].disabledToolbarClasses addObject:NSClassFromString(@"DateViewController")]; //已写在对应的类里了
    
    // 设置主窗口,并设置根控制器
    [UINavigationConfig shared].sx_disableFixSpace = NO;//默认为NO  可以修改
    [UINavigationConfig shared].sx_defaultFixSpace = 2;//默认为0 可以修改
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 所有测试
    UIViewController *rootViewController = [self getMainRootViewController];
    // 只直接测试某个页面
   //rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"SearchBarViewController") alloc] init]];
    
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    [self configureDefaultNavigationBarAppearance];
    [self adjustDevice];
    
    BOOL isFirstLaunchApp = [CJAppLastUtil isFirstLaunchApp];
    NSString *isFirstLaunchAppString = [NSString stringWithFormat:@"是否是第一次安装app:%@", isFirstLaunchApp ? @"是" : @"否"];
    
    BOOL isFirstLaunchThisVersion = [CJAppLastUtil isFirstLaunchThisVersion];
    NSString *isFirstLaunchThisVersionString = [NSString stringWithFormat:@"是否是第一次安装这个版本:%@", isFirstLaunchThisVersion ? @"是" : @"否"];
    
    NSString *firstJudgeString = [NSString stringWithFormat:@"%@\n%@", isFirstLaunchAppString, isFirstLaunchThisVersionString];
    NSLog(@"%@", isFirstLaunchAppString);
    NSLog(@"%@", isFirstLaunchThisVersionString);
    NSLog(@"%@", firstJudgeString);
    
    return YES;
}

- (void)adjustDevice
{
//    if (@available(iOS 11.0, *)) {
//        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        [UICollectionView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        [UIWebView appearance].scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        
//        [UITableView appearance].estimatedRowHeight = 0;
//        [UITableView appearance].estimatedSectionHeaderHeight = 0;
//        [UITableView appearance].estimatedSectionFooterHeight = 0;
//    } else {
//        // Fallback on earlier versions
//    }
}


///配置导航栏
- (void)configureDefaultNavigationBarAppearance {
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //改变导航栏背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    //改变导航栏的字体
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont systemFontOfSize:21]}];
}

- (void)configureDefaultBarButtonItemAppearance {
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
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
