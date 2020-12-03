//
//  TSBlockTextFieldViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TSBlockTextFieldViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <CQDemoKit/CJUIKitToastUtil.h>

#import "UITextField+CJTextChangeBlock.h"
#import "UITextField+CJAddInputAccessoryView.h"

@interface TSBlockTextFieldViewController ()  {

}

@end

@implementation TSBlockTextFieldViewController

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager
    
    UIView *parentView = self.containerView;
    
    /* 1、测试UITextField的cjTextDidChangeBlock方法 */
    UILabel *testNoteLabel = [DemoLabelFactory testExplainLabel];
    testNoteLabel.text = @"测试UITextField的cjTextDidChangeBlock方法";
    [parentView addSubview:testNoteLabel];
    [testNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        if (parentView == self.view) {
            make.top.mas_equalTo(parentView).mas_offset(120);
        } else { //scrollView的containerView
            make.top.mas_equalTo(parentView).mas_offset(20);
        }
        make.height.mas_equalTo(80);
    }];
    
    UITextField *uiTextField = [TSBlockTextFieldViewController __textField];
    uiTextField.placeholder = @"测试UITextField的cjTextDidChangeBlock方法";
    [parentView addSubview:uiTextField];
    [uiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(testNoteLabel);
        make.right.mas_equalTo(testNoteLabel);
        make.top.mas_equalTo(testNoteLabel.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(30);    //系统默认高度30
    }];
    [uiTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
    }];
    self.uiTextField = uiTextField;
    
    
    
    
    /* 2、测试系统UITextField的inputAccessoryView */
    UILabel *testNoteLabel2 = [DemoLabelFactory testExplainLabel];
    testNoteLabel2.text = @"测试系统UITextField的inputAccessoryView\n③测试系统UITextField的摇动Shake";
    [parentView addSubview:testNoteLabel2];
    [testNoteLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        make.top.mas_equalTo(uiTextField.mas_bottom).mas_offset(120);
        make.height.mas_equalTo(80);
    }];
    
    UITextField *accessoryTextField = [TSBlockTextFieldViewController __textField];
    accessoryTextField.placeholder = @"测试UITextField的cjTextDidChangeBlock方法";
    [parentView addSubview:accessoryTextField];
    [accessoryTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(testNoteLabel);
        make.right.mas_equalTo(testNoteLabel);
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

    
    [self updateScrollHeightWithBottomInterval:40
                     accordingToLastBottomView:accessoryTextField];
}


+ (UITextField *)__textField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    [textField setBorderStyle:UITextBorderStyleLine];
    textField.placeholder = @"测试UITextField的cjTextDidChangeBlock方法";
    
    return textField;
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    [self.containerView endEditing:YES];
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
