//
//  TSTextFieldClickViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TSTextFieldClickViewController.h"
#import <CQDemoKit/CJUIKitToastUtil.h>

#import "UITextField+CJPadding.h"
#import "UIView+CJShake.h"
#import "CJTextField.h"

#import "BBXDAreaCodeTextField.h"

#import "TSButtonFactory.h"


@interface TSTextFieldClickViewController () <UITextFieldDelegate> {

}
@property (nonatomic, strong) BBXDAreaCodeTextField *areaCodeTextField;
@property (nonatomic, strong) UIAlertController *regionAlertController;
@property (nonatomic, strong) NSArray<NSString *> *regions;

@property (nonatomic, strong) UILabel *textPicker;   /**< 文本框的inputView */

@end

@implementation TSTextFieldClickViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    
    UIView *parentView = self.containerView;
    
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
        make.height.mas_equalTo(38);
        if (parentView == self.view) {
            make.top.mas_equalTo(parentView).mas_offset(120);
        } else { //scrollView的containerView
            make.top.mas_equalTo(parentView).mas_offset(20);
        }
    }];
    self.areaCodeTextField = areaCodeTextField;
    
    /* 测试不可以输入,只能用选择的文本框 CJTextField */
    UILabel *testCanInputNoteLabel = [DemoLabelFactory testExplainLabel];
    testCanInputNoteLabel.text = @"测试不可以输入,只能用选择的文本框 CJTextField\n①测试文本框点击后是弹出视图而不是弹出键盘\n②测试";
    [parentView addSubview:testCanInputNoteLabel];
    [testCanInputNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        make.top.mas_equalTo(areaCodeTextField.mas_bottom).mas_offset(40);
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
    
    
    [self updateScrollHeightWithBottomInterval:40
                     accordingToLastBottomView:switchLabel];
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
    
    if (textField == self.areaCodeTextField) {
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
