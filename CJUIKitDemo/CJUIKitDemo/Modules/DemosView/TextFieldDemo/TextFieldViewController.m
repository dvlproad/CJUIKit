//
//  TextFieldViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextFieldViewController.h"

#import "UITextField+CJTextChangeBlock.h"
#import "UITextField+CJSelectedTextRange.h"
#import "UIView+CJShake.h"

#import "UITextField+CJPadding.h"
#import "CJTextField.h"

#import "BBXDAreaCodeTextField.h"

#import <CJBaseUIKit/CJToast.h>
#import <CJFoundation/NSString+CJValidate.h>

#import "CJDefaultToolbar.h"
#import "UITextField+CJAddInputAccessoryView.h"


#import "UIImage+CJCreate.h"

@interface TextFieldViewController () <UITextFieldDelegate> {

}
@property (nonatomic, strong) BBXDAreaCodeTextField *areaCodeTextField;
@property (nonatomic, strong) UIAlertController *regionAlertController;
@property (nonatomic, strong) NSArray<NSString *> *regions;

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    
    UIView *parentView = self.containerView;
    
    /* 1、测试系统UITextField的文本改变 */
    UILabel *testNoteLabel = [DemoLabelFactory testLeftCyanLabel];
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
    
    UITextField *textDidChangeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    textDidChangeTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
    //[textDidChangeTextField setBorderStyle:UITextBorderStyleLine];
    textDidChangeTextField.placeholder = @"测试系统UITextField的runtime方法";
    [parentView addSubview:textDidChangeTextField];
    [textDidChangeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(testNoteLabel);
        make.right.mas_equalTo(testNoteLabel);
        make.top.mas_equalTo(testNoteLabel.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(30);    //系统默认高度30
    }];
    self.textDidChangeTextField = textDidChangeTextField;
    
    textDidChangeTextField.delegate = self;
    [textDidChangeTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
    }];
    
    /* inputAccessoryView的例子 */
    //方法1：
//    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    CJDefaultToolbar *inputToolBar = [[CJDefaultToolbar alloc] initWithFrame:CGRectMake(0,0, screenWidth, 44)];
//    inputToolBar.confirmHandle = ^{
//        [self.textField resignFirstResponder];
//    };
//    self.textDidChangeTextField.inputAccessoryView = inputToolBar;
    
    //方法2：
    [textDidChangeTextField addDefaultInputAccessoryViewWithDoneButtonClickBlock:^(UITextField *textField) {
        [textField resignFirstResponder];
    }];

    
    /* 测试区域选择 */
    self.regions = @[@"中国 +86", @"香港 +852"];
    
    BBXDAreaCodeTextField *areaCodeTextField = [[BBXDAreaCodeTextField alloc] initWithFrame:CGRectZero];
    areaCodeTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
    areaCodeTextField.text = self.regions[0];
    __weak typeof(self)weakSelf = self;
    areaCodeTextField.chooseAreaCodeBlock = ^(BBXDAreaCodeTextField *textField) {
        [weakSelf presentViewController:self.regionAlertController animated:YES completion:nil];
    };
    [parentView addSubview:areaCodeTextField];
    [areaCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(parentView);
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(textDidChangeTextField.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(38);
    }];
    self.areaCodeTextField = areaCodeTextField;
    
    CJTextField *placeholderTextField = [[CJTextField alloc] initWithFrame:CGRectZero];
    placeholderTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
    placeholderTextField.placeholder = @"测试添加左视图后placeholder的位置";
    [parentView addSubview:placeholderTextField];
    [placeholderTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(parentView);
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.top.mas_equalTo(areaCodeTextField.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(40);
    }];
    [self completeTextField:placeholderTextField withLeftButtonTitle:@"-" leftButtonAction:nil rightButtonTitle:@"+" rightButtonAction:nil];
    
    
    
    
    /* 测试不可以输入,只能用选择的文本框 CJChooseTextTextField */
    UILabel *testCanInputNoteLabel = [DemoLabelFactory testLeftCyanLabel];
    testCanInputNoteLabel.text = @"测试不可以输入,只能用选择的文本框 CJChooseTextTextField\n①测试文本框点击后是弹出视图而不是弹出键盘\n②测试";
    [parentView addSubview:testCanInputNoteLabel];
    [testCanInputNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(parentView).mas_offset(-20);
        make.top.mas_equalTo(placeholderTextField.mas_bottom).mas_offset(40);
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
    
    UILabel *switchLabel = [DemoLabelFactory testLeftCyanLabel];
    switchLabel.text = @"是否可以输入，不能输入时候，需要隐藏TextField的光标";
    [parentView addSubview:switchLabel];
    [switchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(20);
        make.right.mas_equalTo(canInputSwitch.mas_left);
        make.top.mas_equalTo(self.canInputTextField.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    
    /* 测试一个可以在自己输入的字符串前后添加其他额外字符串的文本框 CJExtraTextTextField */
    UILabel *testExtraTextNoteLabel = [DemoLabelFactory testLeftCyanLabel];
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
    
    [self updateScrollHeightWithLastBottomView:self.extraTextTextField bottom:40];
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
        self.canInputTextField.hideMenuController = NO;
    } else {
        self.canInputTextField.hideMenuController = YES;
    }
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.textDidChangeTextField) {
        textField.secureTextEntry = YES;
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
    
    NSString *oldText = textField.text;
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:string];//若允许改变，则会改变成的新文本
    if ([newText length] > 10) {
        [CJToast shortShowMessage:@"文本过长，超过最大的10个字符了"];
        [textField cjShake];
        return NO;
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    [self.containerView endEditing:YES];
}


#pragma mark - Lazyload
- (CJChooseTextTextField *)canInputTextField {
    if (_canInputTextField == nil) {
        _canInputTextField = [[CJChooseTextTextField alloc] initWithFrame:CGRectZero];
        _canInputTextField.delegate = self;
        _canInputTextField.textAlignment = NSTextAlignmentCenter;
        _canInputTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
        
        [self completeTextField:_canInputTextField withLeftButtonTitle:@"-" leftButtonAction:@selector(leftButtonAction:) rightButtonTitle:@"+" rightButtonAction:@selector(rightButtonAction:)];
        
        UILabel *pickerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
        pickerView.backgroundColor = [UIColor redColor];
        pickerView.text = @"一个文本框中的文本只能来源于选择的时候:\n因为这是一个pickerView,而不是系统或自定义的输入键盘等,所以\n首先肯定需要①隐藏光标，\n其次一般②最多允许弹出选择、复制操作";
        pickerView.textAlignment = NSTextAlignmentLeft;
        pickerView.textColor = [UIColor greenColor];
        pickerView.font = [UIFont systemFontOfSize:19];
        pickerView.numberOfLines = 0;
        [_canInputTextField setTextOnlyFromPickerView:pickerView];
    }
    return _canInputTextField;
}

- (void)completeTextField:(CJTextField *)textField
      withLeftButtonTitle:(NSString *)leftTitle
         leftButtonAction:(SEL)leftButtonAction
         rightButtonTitle:(NSString *)rightTitle
        rightButtonAction:(SEL)rightButtonAction
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor orangeColor];
    //UIImage *leftNormalImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    //[leftButton setImage:leftNormalImage forState:UIControlStateNormal];
    [leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton.titleLabel setBackgroundColor:[UIColor redColor]];
    [leftButton addTarget:self action:leftButtonAction forControlEvents:UIControlEventTouchUpInside];
    [leftButton setFrame:CGRectMake(0, 0, 20, 20)];
    
    textField.leftView = leftButton;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftViewLeftOffset = 10;
    textField.leftViewRightOffset = 10;
    
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor orangeColor];
    //UIImage *rightNormalImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    //[rightButton setImage:rightNormalImage forState:UIControlStateNormal];
    [rightButton setTitle:rightTitle forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton.titleLabel setBackgroundColor:[UIColor redColor]];
    [rightButton addTarget:self action:rightButtonAction forControlEvents:UIControlEventTouchUpInside];
    [rightButton setFrame:CGRectMake(0, 0, 20, 20)];
    
    textField.rightView = rightButton;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightViewLeftOffset = 10;
    textField.rightViewRightOffset = 10;
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
