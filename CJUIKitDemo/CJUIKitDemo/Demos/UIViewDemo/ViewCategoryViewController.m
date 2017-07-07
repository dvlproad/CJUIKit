//
//  ViewCategoryViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ViewCategoryViewController.h"

#import "UIView+CJDragAction.h"
#import "UIView+CJKeepBounds.h"

@interface ViewCategoryViewController ()

@end

@implementation ViewCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dragAndKeepBoundsButton.cjDragEnable = YES;
    [self.dragAndKeepBoundsButton setCjDragEndBlock:^(UIView *view) {
        [view cjKeepBoundsWithBoundEdgeInsets:UIEdgeInsetsZero
                isKeepBoundsXYWhenBeyondBound:YES
             isKeepBoundsXWhenContaintInBound:NO];
    }];
}

- (IBAction)keepBounds:(UIButton *)button {
    [button cjKeepBoundsWithBoundEdgeInsets:UIEdgeInsetsZero
              isKeepBoundsXYWhenBeyondBound:YES
           isKeepBoundsXWhenContaintInBound:NO];
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
