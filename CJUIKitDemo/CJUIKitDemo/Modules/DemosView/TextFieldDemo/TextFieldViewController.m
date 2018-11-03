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

#import "CJToast.h"

#ifdef CJTESTPOD
#import "NSString+CJValidate.h"
#else
#import <CJFoundation/NSString+CJValidate.h>
#endif

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
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    //[textField setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(140);
        make.height.mas_equalTo(30);    //系统默认高度30
    }];
    self.textField = textField;
    
    textField.delegate = self;
    [textField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
    }];

    
    self.regions = @[@"中国 +86", @"香港 +852"];
    
    BBXDAreaCodeTextField *areaCodeTextField = [[BBXDAreaCodeTextField alloc] initWithFrame:CGRectZero];
    areaCodeTextField.text = self.regions[0];
    __weak typeof(self)weakSelf = self;
    areaCodeTextField.chooseAreaCodeBlock = ^(BBXDAreaCodeTextField *textField) {
        [weakSelf presentViewController:self.regionAlertController animated:YES completion:nil];
    };
    [self.view addSubview:areaCodeTextField];
    [areaCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(self.view).mas_offset(190);
        make.height.mas_equalTo(38);
    }];
    self.areaCodeTextField = areaCodeTextField;
    
    CJTextField *textField2 = [[CJTextField alloc] initWithFrame:CGRectZero];
    textField2.backgroundColor = [UIColor lightGrayColor];
    textField2.placeholder = @"测试placeholder位置";
    [self.view addSubview:textField2];
    [textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(self.view).mas_offset(250);
        make.height.mas_equalTo(40);
    }];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    leftView.backgroundColor = [UIColor greenColor];
    textField2.leftView = leftView;
    textField2.leftViewMode = UITextFieldViewModeAlways;
    textField2.leftViewLeftOffset = 10;
    textField2.leftViewRightOffset = 10;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    rightView.backgroundColor = [UIColor orangeColor];
    textField2.rightView = rightView;
    textField2.rightViewMode = UITextFieldViewModeAlways;
    textField2.rightViewRightOffset = 10;
    textField2.rightViewLeftOffset = 10;
    
    
    
    
    //UITextField
    self.canInputTextField.text = @"20";
    self.canInputTextField.delegate = self;
    self.canInputTextField.textAlignment = NSTextAlignmentCenter;
    self.canInputTextField.backgroundColor = [UIColor greenColor];
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //UIImage *leftNormalImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    //[leftButton setImage:leftNormalImage forState:UIControlStateNormal];
    [leftButton setTitle:@"+" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton.titleLabel setBackgroundColor:[UIColor redColor]];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setFrame:CGRectMake(0, 0, 50, 30)];
    self.canInputTextField.leftView = leftButton;
    self.canInputTextField.leftViewMode = UITextFieldViewModeAlways;
    self.canInputTextField.leftViewLeftOffset = 10;
    self.canInputTextField.leftViewRightOffset = 10;
    
    
    UIImage *rightNormalImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setFrame:CGRectMake(0, 0, 30, 30)];
    self.canInputTextField.rightView = rightButton;
    self.canInputTextField.rightViewMode = UITextFieldViewModeAlways;
    self.canInputTextField.rightViewLeftOffset = 20;
    self.canInputTextField.rightViewRightOffset = 20;
    
    
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
    
    
    
    
    self.extraTextTextField.beforeExtraString = @"+";
    self.extraTextTextField.afterExtraString = @"元";
    self.extraTextTextField.limitTextLength = 4 + 2;
    [self.extraTextTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
        [(CJExtraTextTextField *)textField fixExtraString];
    }];
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
    [self.textField resignFirstResponder];
}


#pragma mark - Lazyload
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
