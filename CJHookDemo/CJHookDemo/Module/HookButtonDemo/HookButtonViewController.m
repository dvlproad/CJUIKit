//
//  HookButtonViewController.m
//  CJHookDemo
//
//  Created by 李超前 on 2019/3/7.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "HookButtonViewController.h"
#import <CJHook/UIButton+CJFixMultiClick.h>

@interface HookButtonViewController ()

@end

@implementation HookButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *multiClikcButton = [DemoButtonFactory blueButton];
    [multiClikcButton setTitle:@"MultiClick(重复点击的最小时间间隔)" forState:UIControlStateNormal];
    [multiClikcButton addTarget:self action:@selector(multiClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:multiClikcButton];
    [multiClikcButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(120);
        make.height.mas_equalTo(44);
    }];
    
    multiClikcButton.cjMinClickInterval = 2;
}

- (void)multiClickAction:(UIButton *)button {
    NSLog(@"重复点击了");
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
