//
//  ProcessLineViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/8/14.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ProcessLineViewController.h"
#import "CustomTripProgressView.h"
#import "ProcessLineView.h"

@interface ProcessLineViewController ()

@end

@implementation ProcessLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CustomTripProgressView *processLineView1 = [[CustomTripProgressView alloc] initWithFrame:CGRectMake(20, 100, 300, 40) andTitles:@[@"1", @"2", @"3", @"4", @"5"]];
    [processLineView1 setSelectIndex:2];
    [self.view addSubview:processLineView1];
    
    ProcessLineView *processLineView = [[ProcessLineView alloc] initWithFrame:CGRectMake(20, 200, 300, 40)];
    [self.view addSubview:processLineView];
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
