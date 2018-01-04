//
//  ButtonViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ButtonViewController.h"
#import "UIButton+CJUpDownStructure.h"
#import "UIButton+CJFixMultiClick.h"

@interface ButtonViewController ()

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.upDownStructureButton setBackgroundColor:[UIColor greenColor]];
    [self.upDownStructureButton setImage:[UIImage imageNamed:@"smail.png"] forState:UIControlStateNormal];
    [self.upDownStructureButton setTitle:@"测试上下结构的文字" forState:UIControlStateNormal];
    [self.upDownStructureButton cjVerticalImageAndTitle:10];
    
    
    self.multiClikcButton.cjMinClickInterval = 2;
}


- (IBAction)multiClickAction:(id)sender {
    NSLog(@"重复点击了");
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
