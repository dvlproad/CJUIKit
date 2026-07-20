//
//  KeyboardUtilViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "KeyboardUtilViewController.h"

@interface KeyboardUtilViewController ()

@end

@implementation KeyboardUtilViewController


- (void)dealloc {
    [self.keyboardUtil unregisterKeyboardNotifications];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CJKeyboardUtil *keyboardUtil = [[CJKeyboardUtil alloc] init];
    [keyboardUtil registerKeyboardNotifications];
    [keyboardUtil setKeyboardWillChangeFrameBlock:^(CGFloat keyboardHeight) {
        self.bottomConstraint.constant = keyboardHeight;
    }];
    self.keyboardUtil = keyboardUtil;
    
    
    //点击隐藏键盘方法①
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

//点击隐藏键盘方法②
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
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
