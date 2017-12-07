//
//  NavigationBarViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarViewController.h"
#import "UIColor+CJHex.h"

@interface NavigationBarViewController ()

@end

@implementation NavigationBarViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];//导航栏背景色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//导航栏返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];//导航栏标题颜色
    
    //将导航栏返回按钮上的文字去掉的方法①:通过将文字的颜色恢复即可
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setBarTintColor:CJColorBlueDark1];//导航栏背景色
    [self.navigationController.navigationBar setTintColor:[UIColor greenColor]];//导航栏返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CJColorGreenDark1}];//导航栏标题颜色
    
    //将导航栏返回按钮上的文字去掉的方法①:通过将文字的颜色设成透明即可
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateHighlighted];
    //将导航栏返回按钮上的文字去掉的方法②:修改显示区域
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
