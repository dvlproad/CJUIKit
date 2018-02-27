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

#import "UIImage+CJCreate.h"

@interface ButtonViewController ()

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.upDownStructureButton setImage:[UIImage imageNamed:@"smail.png"] forState:UIControlStateNormal];
    [self.upDownStructureButton setTitle:@"测试上下结构的文字" forState:UIControlStateNormal];
    [self.upDownStructureButton.imageView setBackgroundColor:[UIColor cyanColor]]; //为了方便查看imageView的范围
    [self.upDownStructureButton.titleLabel setBackgroundColor:[UIColor cyanColor]]; //为了方便查看titleLabel的范围
    [self.upDownStructureButton cjVerticalImageAndTitle:10];
    
    
    
    UIImage *image2 = [UIImage cj_imageWithColor:[UIColor cyanColor] size:CGSizeMake(40, 40)];
    [self.button2 setImage:image2 forState:UIControlStateNormal];
    [self.button2 setTitle:@"测试左右结构的文字" forState:UIControlStateNormal];
    //[self.button2.imageView setBackgroundColor:[UIColor cyanColor]]; //为了方便查看imageView的范围
    [self.button2.titleLabel setBackgroundColor:[UIColor cyanColor]]; //为了方便查看titleLabel的范围
    [self.button2 cjLeftImageOffset:10 imageAndTitleSpacing:10];
    
    
    
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
