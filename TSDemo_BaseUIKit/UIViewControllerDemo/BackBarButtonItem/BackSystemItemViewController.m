//
//  BackSystemItemViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BackSystemItemViewController.h"
//#import <UINavigation-SXFixSpace/UINavigationSXFixSpace.h>
#import "UIViewController+CJSystemBackButtonHandler.h"

@interface BackSystemItemViewController ()

@end

@implementation BackSystemItemViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        // 请在AppDelegate中实现
//        [UINavigationConfig shared].sx_disableFixSpace = NO;//默认为NO  可以修改
//        [UINavigationConfig shared].sx_defaultFixSpace = 20;//默认为0 可以修改
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//方法①
- (BOOL)cj_navigationShouldPopOnBackButton {
    [super customBackBarButtonItemAction];
    
    return NO;
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
