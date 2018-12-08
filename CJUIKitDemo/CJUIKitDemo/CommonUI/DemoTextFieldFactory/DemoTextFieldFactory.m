//
//  DemoTextFieldFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoTextFieldFactory.h"

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

@end
