//
//  MyEqualCellSizeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeViewController.h"

@interface MyEqualCellSizeViewController ()

@end

@implementation MyEqualCellSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

///reload (测试cell的selected状态)
- (IBAction)reloadCollectionView:(id)sender {
    [self.equalCellSizeView.equalCellSizeCollectionView my_reloadDataWithKeepSelectedState:NO];
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
