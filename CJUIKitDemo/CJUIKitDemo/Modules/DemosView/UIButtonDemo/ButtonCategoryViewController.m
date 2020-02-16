//
//  ButtonCategoryViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ButtonCategoryViewController.h"
#import "DemoButtonFactory.h"
#import "CJButtonFactory.h"

@interface ButtonCategoryViewController ()

@end

@implementation ButtonCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"UIButton 颜色测试", nil);
    
    UIButton *themeBGButton = [CJButtonFactory themeBGButton];
    [themeBGButton setTitle:@"以主题色为背景的按钮" forState:UIControlStateNormal];
    [self.view addSubview:themeBGButton];
    [themeBGButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(150);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
    themeBGButton.cjTouchUpInsideBlock = ^(UIButton *button) {
        [CQToast showMessage:@"测试为按钮动态增加的属性\n改变蓝色背景enable"];
    };
    
    UIButton *themeBorderButton = [CJButtonFactory themeBorderButton];
    [themeBorderButton setTitle:@"以主题色为边框的按钮" forState:UIControlStateNormal];
    [self.view addSubview:themeBorderButton];
    [themeBorderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(themeBGButton.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(themeBGButton);
        make.left.mas_equalTo(themeBGButton);
        make.centerX.mas_equalTo(themeBGButton);
    }];
    
    UIView *buttonView = [[UIView alloc] init];
    buttonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(themeBorderButton.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(4*44+3*15+10+10);
    }];
    
    UIButton *normalSelectedButton1 = [CJButtonFactory themeNormalSelectedButton];
    [normalSelectedButton1 setTitle:@"修改(未选中，可点)" forState:UIControlStateNormal];
    normalSelectedButton1.selected = false;
    normalSelectedButton1.enabled = true;

    UIButton *normalSelectedButton2 = [CJButtonFactory themeNormalSelectedButton];
    [normalSelectedButton2 setTitle:@"修改(未选中，不可点)" forState:UIControlStateNormal];
    normalSelectedButton2.selected = false;
    normalSelectedButton2.enabled = false;

    UIButton *normalSelectedButton3 = [CJButtonFactory themeNormalSelectedButton];
    [normalSelectedButton3 setTitle:@"提交(选中，可点)" forState:UIControlStateNormal];
    normalSelectedButton3.selected = true;
    normalSelectedButton3.enabled = true;

    UIButton *normalSelectedButton4 = [CJButtonFactory themeNormalSelectedButton];
    [normalSelectedButton4 setTitle:@"提交(选中，不可点)" forState:UIControlStateNormal];
    normalSelectedButton4.selected = true;
    normalSelectedButton4.enabled = false;

    NSArray *normalSelectedButtons = @[normalSelectedButton1, normalSelectedButton2, normalSelectedButton3, normalSelectedButton4];
    for (UIButton *button in normalSelectedButtons) {
        [buttonView addSubview:button];
    }
    [normalSelectedButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonView).mas_offset(20);
        make.right.mas_equalTo(buttonView).mas_offset(-20);
    }];
    [normalSelectedButtons mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:15 leadSpacing:10 tailSpacing:10];
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
