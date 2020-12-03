//
//  TSTextFieldInputViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TSTextFieldInputViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <CQDemoKit/CJUIKitToastUtil.h>

#import "UIView+CJShake.h"
#import "CJTextField.h"

#import "TSButtonFactory.h"

#import "CJExtraTextTextField.h"


@interface TSTextFieldInputViewController () <UITextFieldDelegate> {

}

@end

@implementation TSTextFieldInputViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    
    UIView *parentView = self.containerView;
    
    /* 测试添加左视图后placeholder的位置 */
    UILabel *testCJTextFieldLabel = [DemoLabelFactory testExplainLabel];
    testCJTextFieldLabel.text = @"测试继承类CJTextField的方法\n①测试CJTextField添加左视图后placeholder的位置\n②测试CJTextField的明文密文切换(请在有第三方键盘的真机上测试)";
    [parentView addSubview:testCJTextFieldLabel];
    [testCJTextFieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        if (parentView == self.view) {
            make.top.mas_equalTo(parentView).mas_offset(120);
        } else { //scrollView的containerView
            make.top.mas_equalTo(parentView).mas_offset(20);
        }
        make.height.mas_equalTo(80);
    }];
    UIButton *changeTFSecureButton = [TSButtonFactory themeNormalSelectedButtonWithNormalTitle:@"明文" selectedTitle:@"密文"];
    [changeTFSecureButton addTarget:self action:@selector(changeSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    self.changeTFSecureButton = changeTFSecureButton;
    CJTextField *cjTextField = [DemoTextFieldFactory textFieldWithLeftLabelText:@"密码:" rightButton:changeTFSecureButton];
    cjTextField.placeholder = @"测试添加左视图后placeholder的位置";
    cjTextField.delegate = self;
    [parentView addSubview:cjTextField];
    [cjTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(testCJTextFieldLabel);
        make.left.mas_equalTo(testCJTextFieldLabel);
        make.top.mas_equalTo(testCJTextFieldLabel.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    self.cjTextField = cjTextField;
    self.changeTFSecureButton.selected = YES;
    self.cjTextField.secureTextEntry = YES;
    CJTextField *noSecureTextField = [DemoTextFieldFactory textFieldWithLeftLabelText:@"用于测试密文框切换"];
    noSecureTextField.placeholder = @"用于测试密文框切换";
    noSecureTextField.delegate = self;
    [parentView addSubview:noSecureTextField];
    [noSecureTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(cjTextField);
        make.left.mas_equalTo(cjTextField);
        make.top.mas_equalTo(cjTextField.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    /* 测试一个可以在自己输入的字符串前后添加其他额外字符串的文本框 CJExtraTextTextField */
    UILabel *testExtraTextNoteLabel = [DemoLabelFactory testExplainLabel];
    testExtraTextNoteLabel.text = @"测试一个可以在自己输入的字符串前后添加其他额外字符串的文本框 CJExtraTextTextField\n①测试文本框输入的时候，有值则在前后加上预定义值\n②测试";
    [parentView addSubview:testExtraTextNoteLabel];
    [testExtraTextNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        make.top.mas_equalTo(noSecureTextField.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(80);
    }];
    CJExtraTextTextField *extraTextTextField = [[CJExtraTextTextField alloc] initWithFrame:CGRectZero];
    extraTextTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
    [parentView addSubview:extraTextTextField];
    [extraTextTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(testExtraTextNoteLabel);
        make.left.mas_equalTo(testExtraTextNoteLabel);
        make.top.mas_equalTo(testExtraTextNoteLabel.mas_bottom);
        make.height.mas_equalTo(38);
    }];
    extraTextTextField.placeholder = @"CJExtraTextTextField";
    extraTextTextField.beforeExtraString = @"+";
    extraTextTextField.afterExtraString = @"元";
    extraTextTextField.limitTextLength = 4 + 2;
//    [extraTextTextField setCjTextDidChangeBlock:^(UITextField *textField) {
//        NSLog(@"textField内容改变了:%@", textField.text);
//        [(CJExtraTextTextField *)textField fixExtraString];
//    }];
    
    [self updateScrollHeightWithBottomInterval:40
                     accordingToLastBottomView:extraTextTextField];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.cjTextField) {
        textField.secureTextEntry = YES;
        self.changeTFSecureButton.selected = YES;
    } else {
        textField.secureTextEntry = NO;
    }
    return YES;
}

//UITextField 没有change的事件
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.cjTextField) {
        NSString *oldText = textField.text;
        NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:string];//若允许改变，则会改变成的新文本
        if ([newText length] > 10) {
            [CJUIKitToastUtil showMessage:@"文本过长，超过最大的10个字符了"];
            [textField cjShake];
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    [self.containerView endEditing:YES];
}

#pragma mark - Private Method
- (void)changeSecureTextEntry:(UIButton *)button {
    button.selected = !button.selected;
    self.cjTextField.secureTextEntry = button.selected;
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
