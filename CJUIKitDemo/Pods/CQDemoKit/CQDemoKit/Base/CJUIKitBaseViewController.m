//
//  CJUIKitBaseViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"

@interface CJUIKitBaseViewController ()

@end

@implementation CJUIKitBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]; // #f5f5f5
}

- (void)showToastMessage:(NSString *)message {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [CJToast showMessage:message inView:view withLabelTextColor:[UIColor blackColor] bezelViewColor:[UIColor whiteColor] hideAfterDelay:2.f];
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
