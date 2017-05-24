//
//  TextFieldViewController.m
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextFieldViewController.h"
#import "UITextField+CJTextChangeBlock.h"
#import "UITextField+CJAddLeftRightView.h"
#import "UITextField+CJLimitTextLength.h"
#import "UIView+CJShake.h"

#import "CJToast.h"
#import <CJFoundation/NSString+CJValidate.h>

@interface TextFieldViewController () <UITextFieldDelegate>

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.textFiled.delegate = self;
    [self.textFiled setCjTextChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
        if (![textField.text cj_validateEmail]) {
            NSLog(@"不满足邮件格式");
            [textField cjShake];
        }
        
    }];
    
    self.textFiled.text = @"测试文本的改变";
    
    [self.textFiled cj_limitTextLength:20 withLimitCompleteBlock:^{
        [CJToast showMessage:@"文本过长，超过最大的20个字符了"];
        [self.textFiled cjShake];
    }];
    
    
    
    //UITextField
    self.canInputTextField.text = @"20";
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    inputView.backgroundColor = [UIColor redColor];
    
    [self.canInputTextField setTextOnlyFromInputView:inputView];
    [self.canInputTextField addLeftButtonWithNormalImage:[UIImage imageNamed:@"plus"] leftHandel:^(UITextField *textField) {
        NSLog(@"左边按钮点击");
        NSInteger value = [textField.text integerValue] - 1;
        textField.text = [@(value) stringValue];
    }];
    
    [self.canInputTextField addRightButtonWithNormalImage:[UIImage imageNamed:@"plus"] rightHandel:^(UITextField *textField) {
        NSLog(@"右边按钮点击");
        NSInteger value = [textField.text integerValue] + 1;
        textField.text = [@(value) stringValue];
    }];
    
    [self.canInputSwitch addTarget:self action:@selector(canInputSwitchAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)canInputSwitchAction:(UISwitch *)canInputSwitch {
    if (canInputSwitch.isOn) {
        self.canInputTextField.hideMenuController = NO;
    } else {
        self.canInputTextField.hideMenuController = YES;
    }
}



//UITextField 没有change的事件
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textFiled resignFirstResponder];
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
