//
//  TSTextFieldAccessoryViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TSTextFieldAccessoryViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <CQDemoKit/CJUIKitToastUtil.h>

#import "UITextField+CJAddInputAccessoryView.h"

@interface TSTextFieldAccessoryViewController ()  {

}

@end

@implementation TSTextFieldAccessoryViewController

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
    
    /* 1、测试系统UITextField的inputAccessoryView */
    UILabel *testNoteLabel2 = [DemoLabelFactory testExplainLabel];
    testNoteLabel2.text = @"测试系统UITextField的inputAccessoryView\n③测试系统UITextField的摇动Shake";
    [parentView addSubview:testNoteLabel2];
    [testNoteLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        if (parentView == self.view) {
            make.top.mas_equalTo(parentView).mas_offset(120);
        } else { //scrollView的containerView
            make.top.mas_equalTo(parentView).mas_offset(20);
        }
        make.height.mas_equalTo(80);
    }];

    UITextField *accessoryTextField = [self __textField];
    accessoryTextField.placeholder = @"测试UITextField的cjTextDidChangeBlock方法";
    [parentView addSubview:accessoryTextField];
    [accessoryTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(testNoteLabel2);
        make.right.mas_equalTo(testNoteLabel2);
        make.top.mas_equalTo(testNoteLabel2.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(30);    //系统默认高度30
    }];
    /* inputAccessoryView的例子 */
    //方法1：
//    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    CJDefaultToolbar *inputToolBar = [[CJDefaultToolbar alloc] initWithFrame:CGRectMake(0,0, screenWidth, 44)];
//    inputToolBar.confirmHandle = ^{
//        [self.textField resignFirstResponder];
//    };
//    accessoryTextField.inputAccessoryView = inputToolBar;

    //方法2：
    [accessoryTextField addDefaultInputAccessoryViewWithDoneButtonClickBlock:^(UITextField *bTextField) {
        [bTextField resignFirstResponder];
    }];
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
