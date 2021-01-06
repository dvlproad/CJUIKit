//
//  TSTextFieldDelegateViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TSTextFieldDelegateViewController.h"
#import "CQBlockTextField.h"

@interface TSTextFieldDelegateViewController () <UITextFieldDelegate>  {

}

@end

@implementation TSTextFieldDelegateViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UIView *parentView = self.view;
    
    /* 1、测试UITextField的cjTextDidChangeBlock方法 */
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    CQBlockTextField *textField = [[CQBlockTextField alloc] initWithTextDidChangeBlock:nil];
    [textField updateMaxTextLength:10];
    
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    [textField setBorderStyle:UITextBorderStyleLine];
    textField.placeholder = @"测试UITextField的delegate方法";
    [parentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).offset(20);
        make.centerX.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(100);
        make.height.mas_equalTo(30);    //系统默认高度30
    }];
    
//    textField.delegate = self;
//    [textField addTarget:self action:@selector(__textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *oldText = textField.text;
    NSLog(@"oldText = %@, range = %@, string = %@", oldText, NSStringFromRange(range), string);
    
    return YES;
}

/**
 *  文本内容改变的事件
 */
- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"textField内容改变了:%@", textField.text);
}


#pragma mark - Private Method
/**
 *  文本内容改变的事件
 */
- (void)__textFieldDidChange:(UITextField *)textField {
    // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return;
    }
    
    // 过滤空格
    NSString *oldText = textField.text;
    NSLog(@"变化后的文本内容为:%@", oldText);
}


#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan...");
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
