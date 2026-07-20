//
//  KeyboardAvoidingViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "KeyboardAvoidingViewController.h"

@interface KeyboardAvoidingViewController () <UITextFieldDelegate>

@end

@implementation KeyboardAvoidingViewController

- (void)dealloc {
    [self.scrollView cj_unRegisterKeyboardNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"键盘处理", nil);
    
    UIView *parentView = self.containerView;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = NSLocalizedString(@"请输入内容", nil);
    textField.backgroundColor = [UIColor whiteColor];
    [parentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.centerX.mas_equalTo(parentView);
        make.bottom.mas_equalTo(parentView).mas_offset(-140);
        make.height.mas_equalTo(30);
    }];
    textField.delegate = self;
    self.textField = textField;
    
    
    [self.scrollView cj_registerKeyboardNotifications];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;//设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)keyboardHide:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
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
