//
//  BackCustomItemViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BackCustomItemViewController.h"

#import "UIViewController+CJCustomBackBarButtonItem.h"

@interface BackCustomItemViewController ()

@end

@implementation BackCustomItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //方法②：测试自定义的返回按钮
    [self cj_setCustomBackBarButtonItemWithTarget:self action:@selector(customBackBarButtonItemAction)];
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
