//
//  TranslucentLayoutViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TranslucentLayoutViewController.h"

@interface TranslucentLayoutViewController () {
    
}
@property (nonatomic, assign, readonly) BOOL oldTranslucent;

@end

@implementation TranslucentLayoutViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = self.oldTranslucent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _oldTranslucent = self.navigationController.navigationBar.translucent;
    if (_oldTranslucent) { //将translucent设为了NO，视图布局0才不会有问题
        self.navigationController.navigationBar.translucent = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Translucent(UIView)", nil);
    
    UIButton *cjTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cjTestButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [cjTestButton setTitle:@"CJTestButton" forState:UIControlStateNormal];
    [cjTestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cjTestButton setTitleColor:[UIColor cjColorWithHexString:@"#3388FF"] forState:UIControlStateSelected];
    [cjTestButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cjTestButton addTarget:self action:@selector(cjTestButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton];
    [cjTestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(100);
    }];
}

- (void)cjTestButtonAction:(UIButton *)button {
    
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
