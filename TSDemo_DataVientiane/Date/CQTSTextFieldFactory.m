//
//  CQTSTextFieldFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSTextFieldFactory.h"
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>

@implementation CQTSTextFieldFactory

/*
 *  含加减操作的的文本框
 *
 *  @param leftButtonHandle     左侧减-操作的事件
 *  @param rightButtonHandle    右侧加+操作的事件
 *
 *  @return 截取后的字符串长度
 */
+ (CJTextField *)textFieldWithMinusHandle:(void(^)(UIButton *button))leftButtonHandle
                                addHandle:(void(^)(UIButton *button))rightButtonHandle
{
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
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
