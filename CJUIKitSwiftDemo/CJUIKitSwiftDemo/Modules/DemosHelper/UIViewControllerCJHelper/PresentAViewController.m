//
//  PresentAViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/8/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "PresentAViewController.h"
#import "PresentBViewController.h"

@implementation PresentAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [presentButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [presentButton setTitle:@"Present BViewController" forState:UIControlStateNormal];
    [presentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [presentButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [presentButton addTarget:self action:@selector(presentNextViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
    [presentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.center.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
}

- (void)presentNextViewController {
    PresentBViewController *viewController = [[PresentBViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
