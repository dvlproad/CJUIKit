//
//  TSShareHUDDissmissViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSShareHUDDissmissViewController.h"
#import "CJButtonFactory.h"
#import "BackFromShareHUDViewController.h"

@interface TSShareHUDDissmissViewController ()

@end

@implementation TSShareHUDDissmissViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"UIButton 颜色测试", nil);
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"本页面始终不能出现HUD，即使从其他有HUD的页面返回";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(150);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *themeBGButton = [CJButtonFactory themeBGButton];
    [themeBGButton setTitle:@"以主题色为背景的按钮" forState:UIControlStateNormal];
    [themeBGButton addTarget:self action:@selector(testDoubleProgressHUD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:themeBGButton];
    [themeBGButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void)testDoubleProgressHUD {
    BackFromShareHUDViewController *viewController = [[BackFromShareHUDViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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
