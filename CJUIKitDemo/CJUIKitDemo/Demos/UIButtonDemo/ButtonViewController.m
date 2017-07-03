//
//  ButtonViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ButtonViewController.h"
#import "UIButton+CJUpDownStructure.h"

@interface ButtonViewController ()

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.button setBackgroundColor:[UIColor greenColor]];
    [self.button setImage:[UIImage imageNamed:@"smail.png"] forState:UIControlStateNormal];
    [self.button setTitle:@"测试上下结构的文字" forState:UIControlStateNormal];
    [self.button cjVerticalImageAndTitle:10];
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
