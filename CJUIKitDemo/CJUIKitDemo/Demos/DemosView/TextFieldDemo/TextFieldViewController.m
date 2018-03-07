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
#import "UITextField+CJSelectedTextRange.h"
#import "UIView+CJShake.h"

#import "CJToast.h"

#ifdef CJTESTPOD
#import "NSString+CJValidate.h"
#else
#import <CJFoundation/NSString+CJValidate.h>
#endif

#import "CJDefaultToolbar.h"
#import "UITextField+CJAddInputAccessoryView.h"


#import "UIImage+CJCreate.h"

@interface TextFieldViewController () <UITextFieldDelegate>

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
        make.height.mas_equalTo(100);    //系统默认高度30
    }];
    self.textField = textField;
    
    textField.delegate = self;
    [textField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
    }];
    
    textField.backgroundColor = [UIColor greenColor];
    
    UIImage *leftNormalImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    [textField cj_addLeftButtonWithSize:CGSizeMake(30, 30) leftOffset:10 rightOffset:10 leftNormalImage:leftNormalImage leftHandel:^(UITextField *textField) {
        NSLog(@"左边按钮点击");
        NSInteger value = [textField.text integerValue] - 1;
        textField.text = [@(value) stringValue];
    }];
    
    UIImage *rightNormalImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    [textField cj_addRightButtonWithSize:CGSizeMake(30, 30) rightOffset:20 leftOffset:20 rightNormalImage:rightNormalImage rightHandle:^(UITextField *textField) {
        NSLog(@"右边按钮点击");
        NSInteger value = [textField.text integerValue] + 1;
        textField.text = [@(value) stringValue];
    }];
    
    
    //UITextField
    self.canInputTextField.text = @"20";
    self.canInputTextField.delegate = self;
    self.canInputTextField.textAlignment = NSTextAlignmentCenter;
    
    UIImage *image = [UIImage imageNamed:@"plus"];
    [self.canInputTextField cj_addLeftButtonWithSize:CGSizeMake(30, 30) leftOffset:0 rightOffset:0 leftNormalImage:image leftHandel:^(UITextField *textField) {
        NSLog(@"左边按钮点击");
        NSInteger value = [textField.text integerValue] - 1;
        textField.text = [@(value) stringValue];
    }];
    
    [self.canInputTextField cj_addRightButtonWithSize:CGSizeMake(30, 30) rightOffset:0 leftOffset:0 rightNormalImage:image rightHandle:^(UITextField *textField) {
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
    
    
    
    
    self.extraTextTextField.beforeExtraString = @"+";
    self.extraTextTextField.afterExtraString = @"元";
    self.extraTextTextField.limitTextLength = 4 + 2;
    [self.extraTextTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        NSLog(@"textField内容改变了:%@", textField.text);
        [(CJExtraTextTextField *)textField fixExtraString];
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
