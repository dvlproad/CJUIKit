//
//  TextFieldViewController.m
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextFieldViewController.h"

@interface TextFieldViewController () <UITextFieldDelegate>

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textFiled.text = @"原始文本";
    self.textFiled.delegate = self;
    [self.textFiled setTextChangeBlock:^(CJTextField *textField) {
        NSLog(@"文本改变了");
    }];
    
    
    //CJAddSubtractTextField
    self.addSubtractTextField.delegate = self;
    self.addSubtractTextField.text = @"20";
    self.addSubtractTextField.hideMenuController = YES;
    [self.addSubtractTextField addLeftButtonImage:[UIImage imageNamed:@"plus"] withLeftHandel:^(UITextField *textField) {
        NSLog(@"左边按钮点击");
        NSInteger value = [textField.text integerValue] - 1;
        textField.text = [@(value) stringValue];
    }];
    
    [self.addSubtractTextField addRightButtonImage:[UIImage imageNamed:@"plus"] withRightHandel:^(UITextField *textField) {
        NSLog(@"右边按钮点击");
        NSInteger value = [textField.text integerValue] + 1;
        textField.text = [@(value) stringValue];
    }];
    
    //CJAddSubtractTextField 不可手动输入
    self.cannotInputAddSubtractTextField.delegate = self;
    self.cannotInputAddSubtractTextField.text = @"20";
    self.cannotInputAddSubtractTextField.hideCursor = YES;
    self.cannotInputAddSubtractTextField.hideMenuController = YES;
    [self.cannotInputAddSubtractTextField addLeftButtonImage:[UIImage imageNamed:@"plus"] withLeftHandel:^(UITextField *textField) {
        NSLog(@"左边按钮点击");
        NSInteger value = [textField.text integerValue] - 1;
        textField.text = [@(value) stringValue];
    }];
    
    [self.cannotInputAddSubtractTextField addRightButtonImage:[UIImage imageNamed:@"plus"] withRightHandel:^(UITextField *textField) {
        NSLog(@"右边按钮点击");
        NSInteger value = [textField.text integerValue] + 1;
        textField.text = [@(value) stringValue];
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.cannotInputAddSubtractTextField) {
        NSLog(@"点击了文本框，这里可以用于弹出视图");
        return NO;
    }
    
    return YES;
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
