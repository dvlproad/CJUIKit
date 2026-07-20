//
//  ColorViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ColorViewController.h"
#import "UIColor+CJHex.h"

@interface ColorViewController ()

@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"测试颜色的设置方法", nil);
    
    //以下三种设置颜色一样
    self.view.backgroundColor = CJColorFromHexString(@"#FFFFFF");
    
    UIView *buttonView = [[UIView alloc] init];
    buttonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(300);
    }];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = CJColorFromHexValue(0x43FBFE);
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = CJColorFromHexString(@"0x43FBFE");
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = CJColorFromHexString(@"#43FBFE");
    
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = CJColorFromHexStringAndAlpha(@"#192B93", 102/255.0); //#192B9366
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = CJColorFromHexString(@"#192B9366");
    button.layer.borderWidth = 10;
    button.layer.borderColor = CJColorFromHexString(@"#192B9366").CGColor;


    NSArray *themeButtons = @[view1, view2, view3, view4, button];
    for (UIView *view in themeButtons) {
        [buttonView addSubview:view];
    }
    [themeButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonView).mas_offset(20);
        make.right.mas_equalTo(buttonView).mas_offset(-20);
    }];
    [themeButtons mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:15 leadSpacing:10 tailSpacing:10];
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
