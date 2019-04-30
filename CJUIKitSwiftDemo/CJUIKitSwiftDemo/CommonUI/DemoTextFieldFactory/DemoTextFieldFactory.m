//
//  DemoTextFieldFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoTextFieldFactory.h"
#import "CJDemoDatePickerView.h"
#import "UITextField+CJForbidKeyboard.h"

@implementation DemoTextFieldFactory

///含左侧图片的textField，并支持通过leftButtonSelected属性切换图片变化 (使用场景：登录等)
+ (CJTextField *)textFieldWithNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage
{
    CGSize imageSize = CGSizeMake(14, 15);
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    textField.layer.cornerRadius = 6;
    textField.layer.borderWidth = 0.6;
    textField.layer.borderColor = CJColorFromHexString(@"#d2d2d2").CGColor;
    
    [textField addLeftImageWithNormalImage:normalImage selectedImage:selectedImage imageSize:imageSize];
    textField.leftViewLeftOffset = 15;
    textField.leftViewRightOffset = 15;
    
    return textField;
}

///含 左侧label 的textField(使用场景：忘记密码、修改密码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText {
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat lableWidth = screenWidth < 375 ? 90 : 100;
    CGFloat fontSize = screenWidth < 375 ? 15.5 : 17;

    leftLabel.frame = CGRectMake(0, 0, lableWidth, 44);
    //leftLabel.backgroundColor = [UIColor greenColor];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.textColor = CJColorFromHexString(@"#333333");
    leftLabel.font = [UIFont systemFontOfSize:fontSize];
    leftLabel.text = leftLabelText;
    
    textField.leftView = leftLabel;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftViewLeftOffset = 12;
    textField.leftViewRightOffset = 12;
    textField.font = [UIFont systemFontOfSize:fontSize];
    
    return textField;
}

///含 左侧label 和 右侧button 的textField(使用场景：获取验证码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText rightButton:(UIButton *)rightButton {
    CJTextField *textField = [self textFieldWithLeftLabelText:leftLabelText];
    rightButton.frame = CGRectMake(0, 0, 90, 35);
    
    textField.rightView = rightButton;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightViewLeftOffset = 12;
    textField.rightViewRightOffset = 12;

    return textField;
}

/// 用来选择的文本框(文本框中的值只能来源于选择，不能来源于输入)
+ (CJTextField *)textFieldWhichTextOnlyFromPickerView:(UIView *)pickerView {
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
    [textField cj_forbidKeyboardAndTextPicker:pickerView];
    textField.forbidMenuType = CJTextFieldForbidMenuTypeAll;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    
    return textField;
}

/**
 *  用来选择的文本框(文本框中的值只能来源于选择，不能来源于输入)
 *
 *  @param pickerView           pickerView
 *  @param leftButtonHandle     leftButtonHandle
 *  @param rightButtonHandle    rightButtonHandle
 */
+ (CJTextField *)textFieldWhichTextOnlyFromPickerView:(UIView *)pickerView
                                     leftButtonHandle:(void(^)(UIButton *button))leftButtonHandle
                                    rightButtonHandle:(void(^)(UIButton *button))rightButtonHandle
{
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
    [textField cj_forbidKeyboardAndTextPicker:pickerView];
    textField.forbidMenuType = CJTextFieldForbidMenuTypeAll;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor orangeColor];
    UIImage *leftNormalImage = [UIImage imageNamed:@"minus_common_icon"];
    [leftButton setImage:leftNormalImage forState:UIControlStateNormal];
    [leftButton setCjTouchUpInsideBlock:^(UIButton *button) {
        if (leftButtonHandle) {
            leftButtonHandle(button);
        }
    }];
    [leftButton setFrame:CGRectMake(0, 0, 20, 20)];
    
    textField.leftView = leftButton;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftViewLeftOffset = 10;
    textField.leftViewRightOffset = 10;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor orangeColor];
    UIImage *rightNormalImage = [UIImage imageNamed:@"add_common_icon"];
    [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
    [rightButton setCjTouchUpInsideBlock:^(UIButton *button) {
        if (rightButtonHandle) {
            rightButtonHandle(button);
        }
    }];
    [rightButton setFrame:CGRectMake(0, 0, 20, 20)];
    
    textField.rightView = rightButton;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightViewLeftOffset = 10;
    textField.rightViewRightOffset = 10;
    
    return textField;
}

@end
