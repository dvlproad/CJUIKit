//
//  BackCustomItemViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BackCustomItemViewController.h"
#import "UIImage+CJCreate.h"
#import "UIButton+CJMoreProperty.h"

#import "UIViewController+CJCustomBackBarButtonItem.h"

#import <UINavigation-SXFixSpace/UINavigationSXFixSpace.h>

@interface BackCustomItemViewController ()

@end

@implementation BackCustomItemViewController
    
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UINavigationConfig shared].sx_disableFixSpace = NO;//默认为NO  可以修改
    [UINavigationConfig shared].sx_defaultFixSpace = 10;//默认为0 可以修改
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //方法②：测试自定义的返回按钮
    UIImage *redImage = [UIImage cj_imageWithColor:CJColorFromHexString(@"#323f83") size:CGSizeMake(40, 40)];
    [self cj_setCustomBackBarButtonItemWithNormalImage:redImage
                                      highlightedImage:redImage
                                           normalTitle:nil
                                         selectedTitle:nil
                                              withSize:CGSizeZero
                                                target:self
                                    action:@selector(customBackBarButtonItemAction)];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedSpaceBarButtonItem.width = 10;
    
    UIBarButtonItem *fixedSpaceBarButtonItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedSpaceBarButtonItem2.width = 10;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = CJColorFromHexString(@"#323f83");
    [rightButton setTitleColor:CJColorFromHexString(@"#FFFFFF") forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton setCjTouchUpInsideBlock:^(UIButton *button) {
        
    }];
    [rightButton setTitle:@"右键" forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [rightButton setFrame:CGRectMake(0.0f, 0.0f, 70.0f, 40.0f)];
    self.navigationItem.rightBarButtonItems = @[fixedSpaceBarButtonItem2, rightBarButtonItem, fixedSpaceBarButtonItem];
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
