//
//  CJUIKitBaseTabBarViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseTabBarViewController.h"

@interface CJUIKitBaseTabBarViewController ()

@end

@implementation CJUIKitBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_BG"];
    
//    [self setSelectedIndex:0];
//    [self setViewControllers:@[firstNavigationController, secondNavigationController, navigationController3, navigationController4] animated:YES];
}


#pragma mark - Setter
- (void)setTabBarModels:(NSArray<CQDMTabBarModel *> *)tabBarModels {
    _tabBarModels = tabBarModels;
    
    for (CQDMTabBarModel *tabBarModel in tabBarModels) {
        UIViewController *viewController = [self __viewControllerFromTabBarModel:tabBarModel];
        [self addChildViewController:viewController];
    }
}

#pragma mark - Private Method
/*
 *  根据标签页数据获得viewController
 *
 *  @param tabBarModel  标签页数据
 *
 *  @return viewController
 */
- (UIViewController *)__viewControllerFromTabBarModel:(CQDMTabBarModel *)tabBarModel {
    /*
    知识点(UITabBarController):
    ①设置标题tabBarItem.title：为了使得tabBarItem中的title可以和显示在顶部的navigationItem的title保持各自，分别设置.tabBarItem.title和.navigationItem的title的值
    ②设置图片tabBarItem.image：会默认去掉图片的颜色，如果要看到原图片，需要设置图片的渲染模式为UIImageRenderingModeAlwaysOriginal
    ③设置角标tabBarItem.badgeValue：如果没有设置图片，角标默认显示在左上角，设置了图片就会在图片的右上角显示
    */
    UIViewController *viewController = nil;
    Class classEntry = tabBarModel.classEntry;
    NSString *clsString = NSStringFromClass(tabBarModel.classEntry);
    if (tabBarModel.isCreateByXib) {
        viewController = [[classEntry alloc] initWithNibName:clsString bundle:nil];
    } else {
        viewController = [[classEntry alloc] init];
    }
    
    viewController.title = tabBarModel.title;
    viewController.navigationItem.title = tabBarModel.title;
    viewController.tabBarItem.title = tabBarModel.title;
    viewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return rootViewController;;
}



/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_BG"];
    
    UIViewController *viewController1 = [[CQPhoneStepLoginHomeViewController alloc] init];
    viewController1.tabBarItem.title = NSLocalizedString(@"登录", nil);
    viewController1.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    [self addChildViewController:navigationController1];
    
    UIViewController *viewController2 = [[CQImproveNameViewController alloc] initWithIdentityType:CQIdentityTypeBiao];
    viewController2.tabBarItem.title = NSLocalizedString(@"完善表资料", nil);
    viewController2.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    [self addChildViewController:navigationController2];
    
    UIViewController *viewController3 = [[CQImproveNameViewController alloc] initWithIdentityType:CQIdentityTypeLi];
    viewController3.tabBarItem.title = NSLocalizedString(@"完善里资料", nil);
    viewController3.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navigationController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    [self addChildViewController:navigationController3];
    
//    [self setViewControllers:@[navigationController1, navigationController2, navigationController3, navigationController4] animated:YES];
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
