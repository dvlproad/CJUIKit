//
//  TSTextFieldBlockViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TSTextFieldBlockViewController.h"
//#import <IQKeyboardManager/IQKeyboardManager.h>
#import "UITextField+CJTextChangeBlock.h"

@interface TSTextFieldBlockViewController ()  {

}

@end

@implementation TSTextFieldBlockViewController

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager
    
    UIView *parentView = self.view;
    
    /* 1、测试UITextField的cjTextDidChangeBlock方法 */
    UITextField *uiTextField = [self __textField];
    uiTextField.placeholder = @"测试UITextField的cjTextDidChangeBlock方法";
    [parentView addSubview:uiTextField];
    [uiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).offset(20);
        make.centerX.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(100);
        make.height.mas_equalTo(30);    //系统默认高度30
    }];
    
    // 方式1：
//    [uiTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // 方式2：
    uiTextField.cjTextDidChangeBlock = ^(UITextField *bTextField) {
        NSLog(@"textField内容改变了:%@", bTextField.text);
    };
    self.uiTextField = uiTextField;
}

/**
 *  文本内容改变的事件
 */
- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"textField内容改变了:%@", textField.text);
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan...");
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - Private Method
- (UITextField *)__textField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    [textField setBorderStyle:UITextBorderStyleLine];
    textField.placeholder = @"测试UITextField的cjTextDidChangeBlock方法";
    
    return textField;
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
