//
//  TestProgressHUDViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 1/11/19.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestProgressHUDViewController.h"
#import "CQHUDUtil.h"

@interface TestProgressHUDViewController ()

@end

@implementation TestProgressHUDViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 禁止本页面自己返回
    self.navigationController.view.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController.view.userInteractionEnabled = YES;
    });
    
    [CQHUDUtil showProgressHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CQHUDUtil dismissProgressHUD];
    });
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
