//
//  ButtonStructureViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ButtonStructureViewController.h"
#import "TSButtonFactory.h"
#import "UIImage+CJCreate.h"

@interface ButtonStructureViewController ()

@end

@implementation ButtonStructureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *image = [[UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(30, 30)] cj_circleImage];
    
    // 正常图文的按钮(测试用的"左图片+右文字"按钮)
    UIButton *normalStructure = [TSButtonFactory textImageButtonWithTitle:@"正常图文的按钮"
                                                                    image:image
                                                            imagePosition:DemoTextImageButtonLocationDefault];
    [self.view addSubview:normalStructure];
    [normalStructure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(150);
        make.height.mas_equalTo(62);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
    
    // 上图下字按钮
    UIButton *upDownButton = [TSButtonFactory textImageButtonWithTitle:@"上图下字按钮"
                                                                 image:image
                                                         imagePosition:DemoTextImageButtonLocationImageTop];
    [self.view addSubview:upDownButton];
    [upDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(normalStructure.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(normalStructure);
        make.left.mas_equalTo(normalStructure);
        make.centerX.mas_equalTo(normalStructure);
    }];
    
    
    // 左图右字按钮(测试用的"左图片+右文字"按钮)
    UIButton *leftRightButton1 = [TSButtonFactory textImageButtonWithTitle:@"左图右字按钮"
                                                                     image:image
                                                             imagePosition:DemoTextImageButtonLocationLeftImageRightText];
    [self.view addSubview:leftRightButton1];
    [leftRightButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(upDownButton.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(upDownButton);
        make.left.mas_equalTo(upDownButton);
        make.centerX.mas_equalTo(upDownButton);
    }];
    
    // 左字右图按钮(测试用的"左文字+右图片"按钮)
    UIButton *leftRightButton2 = [TSButtonFactory textImageButtonWithTitle:@"左字右图按钮"
                                                                     image:image
                                                             imagePosition:DemoTextImageButtonLocationLeftTextRightImage];
    [self.view addSubview:leftRightButton2];
    [leftRightButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftRightButton1.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(leftRightButton1);
        make.left.mas_equalTo(leftRightButton1);
        make.centerX.mas_equalTo(leftRightButton1);
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
