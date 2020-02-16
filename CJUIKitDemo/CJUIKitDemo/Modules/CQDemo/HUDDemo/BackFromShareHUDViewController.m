//
//  BackFromShareHUDViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 1/11/19.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "BackFromShareHUDViewController.h"
#import "CQHUDUtil.h"

@interface BackFromShareHUDViewController ()

@end

@implementation BackFromShareHUDViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"请求到网络前离开，之前的HUD是否消失", nil);
    
    // 禁止本页面点击返回，而是0.5s后自动返回，以此来模拟在某页面请求到网络前，中途去其他页面，之前的HUD有没有消失
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
