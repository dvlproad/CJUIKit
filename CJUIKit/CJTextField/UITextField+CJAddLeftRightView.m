//
//  UITextField+CJAddLeftRightView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextField+CJAddLeftRightView.h"
#import <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, copy) void (^cjLeftViewHandle)(UITextField *textField);
@property (nonatomic, copy) void (^cjRightViewHandle)(UITextField *textField);

@end

@implementation UITextField (CJAddLeftRightView)

#pragma mark - runtime
static NSString *kCJLeftViewHandleKey = @"kCJLeftViewHandleKey";
static NSString *kCJRightViewHandleKey = @"kCJRightViewHandleKey";

- (void (^)(UITextField *))cjLeftViewHandle {
    return objc_getAssociatedObject(self, (__bridge const void *)(kCJLeftViewHandleKey));
}

- (void)setCjLeftViewHandle:(void (^)(UITextField *))cjLeftViewHandle {
    objc_setAssociatedObject(self, (__bridge const void *)(kCJLeftViewHandleKey), cjLeftViewHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITextField *))cjRightViewHandle {
    return objc_getAssociatedObject(self, (__bridge const void *)(kCJRightViewHandleKey));
}

- (void)setCjRightViewHandle:(void (^)(UITextField *))cjRightViewHandle {
    objc_setAssociatedObject(self, (__bridge const void *)(kCJRightViewHandleKey), cjRightViewHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (UIButton *)addLeftButtonWithNormalImage:(UIImage *)leftNormalImage leftHandel:(void (^)(UITextField *textField))leftHandle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 3, 0)];
    [button setImage:leftNormalImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.cjLeftViewHandle = leftHandle;
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
    self.cjRightViewHandle = rightHandle;
    self.rightView = button;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    return button;
}

- (void)leftButtonClick {
    if (self.cjLeftViewHandle) {
        self.cjLeftViewHandle(self);
    }
}

- (void)rightButtonClick {
    if (self.cjRightViewHandle) {
        self.cjRightViewHandle(self);
    }
}


@end
