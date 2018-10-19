//
//  EdgeLayoutViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "EdgeLayoutViewController.h"

@interface EdgeLayoutViewController () {
    
}
@property (nonatomic, assign) UIRectEdge oldEdgesForExtendedLayout;

@end

@implementation EdgeLayoutViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.edgesForExtendedLayout = self.oldEdgesForExtendedLayout;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _oldEdgesForExtendedLayout = self.edgesForExtendedLayout;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"edgesForExtendedLayout(UIView)", nil);
    
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
