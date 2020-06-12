//
//  TextFieldViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextFieldViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

#import "UITextField+CJTextChangeBlock.h"
#import "UITextField+CJSelectedTextRange.h"
#import "UIView+CJShake.h"

#import "UITextField+CJPadding.h"
#import "CJTextField.h"

#import "BBXDAreaCodeTextField.h"
#import <CJFoundation/NSString+CJValidate.h>

#import "CJDefaultToolbar.h"
#import "UITextField+CJAddInputAccessoryView.h"


#import "UIImage+CJCreate.h"
#import "TSButtonFactory.h""
#import <CQDemoKit/CJUIKitToastUtil.h>

@interface TextFieldViewController () <UITextFieldDelegate> {

}
@property (nonatomic, strong) BBXDAreaCodeTextField *areaCodeTextField;
@property (nonatomic, strong) UIAlertController *regionAlertController;
@property (nonatomic, strong) NSArray<NSString *> *regions;

@property (nonatomic, strong) UILabel *textPicker;   /**< 文本框的inputView */

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    
    UIView *parentView = self.containerView;
    
    /* 1、测试系统UITextField的文本改变 */
    UILabel *testNoteLabel = [DemoLabelFactory testExplainLabel];
    testNoteLabel.text = @"测试系统UITextField的runtime方法\n①测试系统UITextField的文本改变\n②测试系统UITextField的inputAccessoryView\n③测试系统UITextField的摇动Shake";
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
    
    UITextField *uiTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    uiTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
    //[uiTextField setBorderStyle:UITextBorderStyleLine];
    uiTextField.placeholder = @"测试系统UITextField的runtime方法";
    uiTextField.delegate = self;
    [parentView addSubview:uiTextField];
    [uiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(testNoteLabel);
        make.right.mas_equalTo(testNoteLabel);
        make.top.mas_equalTo(testNoteLabel.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(30);    //系统默认高度30
    }];
    self.uiTextField = uiTextField;
    
    uiTextField.delegate = self;
    [uiTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
    }];
    
    /* inputAccessoryView的例子 */
    //方法1：
//    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    CJDefaultToolbar *inputToolBar = [[CJDefaultToolbar alloc] initWithFrame:CGRectMake(0,0, screenWidth, 44)];
//    inputToolBar.confirmHandle = ^{
//        [self.textField resignFirstResponder];
//    };
//    self.uiTextField.inputAccessoryView = inputToolBar;
    
    //方法2：
    [uiTextField addDefaultInputAccessoryViewWithDoneButtonClickBlock:^(UITextField *textField) {
        [textField resignFirstResponder];
    }];

    
    /* 测试区域选择 */
    self.regions = @[@"中国 +86", @"香港 +852"];
    
    BBXDAreaCodeTextField *areaCodeTextField = [[BBXDAreaCodeTextField alloc] initWithFrame:CGRectZero];
    areaCodeTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
    areaCodeTextField.text = self.regions[0];
    areaCodeTextField.delegate = self;
    __weak typeof(self)weakSelf = self;
    areaCodeTextField.chooseAreaCodeBlock = ^(BBXDAreaCodeTextField *textField) {
        [weakSelf presentViewController:self.regionAlertController animated:YES completion:nil];
    };
    [parentView addSubview:areaCodeTextField];
    [areaCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(parentView);
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(uiTextField.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(38);
    }];
    self.areaCodeTextField = areaCodeTextField;
    
    /* 测试添加左视图后placeholder的位置 */
    UILabel *testCJTextFieldLabel = [DemoLabelFactory testExplainLabel];
    testCJTextFieldLabel.text = @"测试继承类CJTextField的方法\n①测试CJTextField添加左视图后placeholder的位置\n②测试CJTextField的明文密文切换(请在有第三方键盘的真机上测试)";
    [parentView addSubview:testCJTextFieldLabel];
    [testCJTextFieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        make.top.mas_equalTo(areaCodeTextField.mas_bottom).mas_offset(40);
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
    
    /* 测试不可以输入,只能用选择的文本框 CJTextField */
    UILabel *testCanInputNoteLabel = [DemoLabelFactory testExplainLabel];
    testCanInputNoteLabel.text = @"测试不可以输入,只能用选择的文本框 CJTextField\n①测试文本框点击后是弹出视图而不是弹出键盘\n②测试";
    [parentView addSubview:testCanInputNoteLabel];
    [testCanInputNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        make.top.mas_equalTo(noSecureTextField.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(80);
    }];
    
    [parentView addSubview:self.canInputTextField];
    [self.canInputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(testCanInputNoteLabel);
        make.left.mas_equalTo(testCanInputNoteLabel);
        make.top.mas_equalTo(testCanInputNoteLabel.mas_bottom);
        make.height.mas_equalTo(38);
    }];
    self.canInputTextField.text = @"20";
    
    //控制是否允许文本框输入的开关
    UISwitch *canInputSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    canInputSwitch.on = YES;
    [canInputSwitch addTarget:self action:@selector(canInputSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [parentView addSubview:canInputSwitch];
    [canInputSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.canInputTextField.mas_bottom);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        make.height.mas_equalTo(31);
        make.width.mas_equalTo(51);
    }];
    self.canInputSwitch = canInputSwitch;
    
    UILabel *switchLabel = [DemoLabelFactory testExplainLabel];
    switchLabel.text = @"是否可以输入，不能输入时候，需要隐藏TextField的光标";
    [parentView addSubview:switchLabel];
    [switchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(canInputSwitch.mas_left);
        make.top.mas_equalTo(self.canInputTextField.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    
    /* 测试一个可以在自己输入的字符串前后添加其他额外字符串的文本框 CJExtraTextTextField */
    UILabel *testExtraTextNoteLabel = [DemoLabelFactory testExplainLabel];
    testExtraTextNoteLabel.text = @"测试一个可以在自己输入的字符串前后添加其他额外字符串的文本框 CJExtraTextTextField\n①测试文本框输入的时候，有值则在前后加上预定义值\n②测试";
    [parentView addSubview:testExtraTextNoteLabel];
    [testExtraTextNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        make.top.mas_equalTo(switchLabel.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(80);
    }];
    self.extraTextTextField = [[CJExtraTextTextField alloc] initWithFrame:CGRectZero];
    self.extraTextTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
    self.extraTextTextField.delegate = self;
    [parentView addSubview:self.extraTextTextField];
    [self.extraTextTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(testExtraTextNoteLabel);
        make.left.mas_equalTo(testExtraTextNoteLabel);
        make.top.mas_equalTo(testExtraTextNoteLabel.mas_bottom);
        make.height.mas_equalTo(38);
    }];
    self.extraTextTextField.placeholder = @"CJExtraTextTextField";
    self.extraTextTextField.beforeExtraString = @"+";
    self.extraTextTextField.afterExtraString = @"元";
    self.extraTextTextField.limitTextLength = 4 + 2;
    [self.extraTextTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
        [(CJExtraTextTextField *)textField fixExtraString];
    }];
    
    [self updateScrollHeightWithBottomInterval:40 accordingToLastBottomView:self.extraTextTextField];
}

- (void)leftButtonAction:(UIButton *)button {
    NSLog(@"左边按钮点击");
    NSInteger value = [self.canInputTextField.text integerValue] - 1;
    self.canInputTextField.text = [@(value) stringValue];
}

- (void)rightButtonAction:(UIButton *)button {
    NSLog(@"右边按钮点击");
    NSInteger value = [self.canInputTextField.text integerValue] + 1;
    self.canInputTextField.text = [@(value) stringValue];
}

- (void)changeSecureTextEntry:(UIButton *)button {
    button.selected = !button.selected;
    self.cjTextField.secureTextEntry = button.selected;
}

- (void)canInputSwitchAction:(UISwitch *)canInputSwitch {
    if (canInputSwitch.isOn) {
        self.canInputTextField.forbidMenuType = CJTextFieldForbidMenuTypeNone;
    } else {
        self.canInputTextField.forbidMenuType = CJTextFieldForbidMenuTypeAll;
    }
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
    
    if (textField == self.uiTextField) {
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    [self.containerView endEditing:YES];
}


#pragma mark - Lazyload
- (CJTextField *)canInputTextField {
    if (_canInputTextField == nil) {
        _canInputTextField = [DemoTextFieldFactory textFieldWhichTextOnlyFromPickerView:self.textPicker leftButtonHandle:^(UIButton *button) {
            [self leftButtonAction:button];
        } rightButtonHandle:^(UIButton *button) {
            [self rightButtonAction:button];
        }];
    }
    return _canInputTextField;
}

- (UILabel *)textPicker {
    if (_textPicker == nil) {
        _textPicker = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
        _textPicker.backgroundColor = [UIColor redColor];
        _textPicker.text = @"一个文本框中的文本只能来源于选择的时候:\n因为这是一个pickerView,而不是系统或自定义的输入键盘等,所以\n首先肯定需要①隐藏光标，\n其次一般②最多允许弹出选择、复制操作";
        _textPicker.textAlignment = NSTextAlignmentLeft;
        _textPicker.textColor = [UIColor greenColor];
        _textPicker.font = [UIFont systemFontOfSize:19];
        _textPicker.numberOfLines = 0;
    }
    return _textPicker;
}


- (UIAlertController *)regionAlertController {
    if (_regionAlertController) return _regionAlertController;
    
    _regionAlertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [_regionAlertController addAction:cancelAction];
    
    __weak typeof(self)weakSelf = self;
    for (NSString *regionString in self.regions) {
        UIAlertAction *regionction = [UIAlertAction actionWithTitle:regionString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.areaCodeTextField.text = action.title;
        }];
        [_regionAlertController addAction:regionction];
    }
    
    return _regionAlertController;
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
