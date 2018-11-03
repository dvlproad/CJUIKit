//
//  NavigationBarRemoveUnderlineViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarRemoveUnderlineViewController.h"
#import "UINavigationBar+CJChangeBG.h"

#import "AppDelegate.h"

@interface NavigationBarRemoveUnderlineViewController ()

@end

@implementation NavigationBarRemoveUnderlineViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self navigationBarReset];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self navigationBarCustomSet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}


#pragma mark - 导航栏的设置
///导航栏的重置
- (void)navigationBarReset {
    [self.navigationController.navigationBar cj_resetBackgroundColor];
    
    
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [delegate configureDefaultBarButtonItemAppearance];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //改变导航栏背景色
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    //改变导航栏的字体
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont systemFontOfSize:21]}];
}

///导航栏在当前页面的自定义
- (void)navigationBarCustomSet {
    /* 改变导航栏 */
    [self.navigationController.navigationBar cj_hideUnderline:YES];//删除导航栏的下划线
    //即[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];//改变导航栏背景色
    
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName : [UIColor redColor],
                                     NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]
                                     };
    //注：使用 [UINavigationBar appearance] 没法立即改变
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
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
