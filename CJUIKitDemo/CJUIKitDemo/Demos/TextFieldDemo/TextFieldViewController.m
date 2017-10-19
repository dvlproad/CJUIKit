//
//  TextFieldViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextFieldViewController.h"
#import "UITextField+CJTextChangeBlock.h"
#import "UITextField+CJAddLeftRightView.h"
#import "UITextField+CJLimitTextLength.h"
#import "UIView+CJShake.h"

#import "CJToast.h"
#import <CJFoundation/NSString+CJValidate.h>

#import "CJDefaultToolbar.h"
#import "UITextField+CJAddInputAccessoryView.h"

@interface TextFieldViewController () <UITextFieldDelegate>

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.textField.delegate = self;
    [self.textField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
        if (![textField.text cj_validateEmail]) {
            [CJToast shortShowMessage:@"不满足邮件格式"];
            [textField cjShake];
        }
    }];
    [self.textField cj_limitTextLength:30 withLimitCompleteBlock:^{
        [CJToast shortShowMessage:@"文本过长，超过最大的30个字符了"];
        [self.textField cjShake];
    }];
    
    self.textField.text = @"validateEmail@163.com";
    
    
    //UITextField
    self.canInputTextField.text = @"20";
    self.canInputTextField.delegate = self;
    self.canInputTextField.textAlignment = NSTextAlignmentCenter;
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
    
    
    UILabel *pickerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    pickerView.backgroundColor = [UIColor redColor];
    pickerView.text = @"一个文本框中的文本只能来源于选择的时候:\n因为这是一个pickerView,而不是系统或自定义的输入键盘等,所以\n首先肯定需要①隐藏光标，\n其次一般②最多允许弹出选择、复制操作";
    pickerView.textAlignment = NSTextAlignmentLeft;
    pickerView.textColor = [UIColor greenColor];
    pickerView.font = [UIFont systemFontOfSize:19];
    pickerView.numberOfLines = 0;
    [self.canInputTextField setTextOnlyFromPickerView:pickerView];
    
    
    
    [self.canInputSwitch addTarget:self action:@selector(canInputSwitchAction:) forControlEvents:UIControlEventValueChanged];
    
    
    /* inputAccessoryView的例子 */
    //方法1：
//    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    CJDefaultToolbar *inputToolBar = [[CJDefaultToolbar alloc] initWithFrame:CGRectMake(0,0, screenWidth, 44)];
//    inputToolBar.confirmHandle = ^{
//        [self.textField resignFirstResponder];
//    };
//    self.textField.inputAccessoryView = inputToolBar;
    
    //方法2：
    [self.textField addDefaultInputAccessoryViewWithDoneButtonClickBlock:^(UITextField *textField) {
        [textField resignFirstResponder];
    }];
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
    
    NSString *oldText = textField.text;
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:string];//若允许改变，则会改变成的新文本
    if ([newText length] > 40) {
        [CJToast shortShowMessage:@"输入内容太长"];
        [textField cjShake];
        return NO;
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
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
