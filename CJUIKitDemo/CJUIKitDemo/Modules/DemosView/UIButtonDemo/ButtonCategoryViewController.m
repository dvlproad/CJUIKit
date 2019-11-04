//
//  ButtonCategoryViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ButtonCategoryViewController.h"
#import "DemoButtonFactory.h"

@interface ButtonCategoryViewController ()

@end

@implementation ButtonCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *blueButton = [DemoButtonFactory blueButton];
    [blueButton setTitle:@"蓝色背景按钮" forState:UIControlStateNormal];
    [self.view addSubview:blueButton];
    [blueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(150);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
    blueButton.cjTouchUpInsideBlock = ^(UIButton *button) {
        [CJToast shortShowMessage:@"测试为按钮动态增加的属性\n改变蓝色背景enable"];
    };
    
    UIButton *whiteButton = [DemoButtonFactory whiteButton];
    [whiteButton setTitle:@"白色背景按钮" forState:UIControlStateNormal];
    [self.view addSubview:whiteButton];
    [whiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(blueButton.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(blueButton);
        make.left.mas_equalTo(blueButton);
        make.centerX.mas_equalTo(blueButton);
    }];
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
