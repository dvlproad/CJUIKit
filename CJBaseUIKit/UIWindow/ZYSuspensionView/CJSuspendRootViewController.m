//
//  CJSuspendRootViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/8/26.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJSuspendRootViewController.h"

@interface CJSuspendRootViewController ()

@end

@implementation CJSuspendRootViewController

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
