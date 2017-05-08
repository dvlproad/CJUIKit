//
//  CJAddSubtractTextField.m
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJAddSubtractTextField.h"

@interface CJAddSubtractTextField ()

@property (nonatomic, copy) void (^leftHandle)(UITextField *textField);
@property (nonatomic, copy) void (^rightHandle)(UITextField *textField);

@end

@implementation CJAddSubtractTextField

- (void)commonInit {
    [super commonInit];
    
    self.textAlignment = NSTextAlignmentCenter;
}

- (UIButton *)addLeftButtonWithNormalImage:(UIImage *)leftNormalImage leftHandel:(void (^)(UITextField *textField))leftHandle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 3, 0)];
    [button setImage:leftNormalImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftHandle = leftHandle;
    self.leftView = button;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    return button;
}

- (UIButton *)addRightButtonWithNormalImage:(UIImage *)rightNormalImage rightHandel:(void (^)(UITextField *textField))rightHandle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 0)];
    [button setImage:rightNormalImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightHandle = rightHandle;
    self.rightView = button;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    return button;
}

- (void)leftButtonClick {
    if (self.leftHandle) {
        self.leftHandle(self);
    }
}

- (void)rightButtonClick {
    if (self.rightHandle) {
        self.rightHandle(self);
    }
}




@end
