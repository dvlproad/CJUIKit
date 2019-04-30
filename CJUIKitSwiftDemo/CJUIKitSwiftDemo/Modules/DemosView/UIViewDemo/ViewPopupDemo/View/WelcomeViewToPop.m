//
//  WelcomeViewToPop.m
//  CJPopupViewDemo
//
//  Created by ciyouzen on 6/22/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "WelcomeViewToPop.h"

static CGFloat kKeyboardHeightPadding = 20; //键盘离输入框最小的自定义的缓冲距离大小


@interface WelcomeViewToPop ()

@property (nonatomic, weak) UITextField *currentTextField; /**< 当前响应的输入框 */
@property (nonatomic, assign) CGFloat offset; /**< 弹出键盘时候view移动的大小 */

@end



@implementation WelcomeViewToPop

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (void)commonInit {
    [self registerNotification];
}

- (void)dealloc {
    [self unregisterNotification];
}

- (void)unregisterNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (IBAction)cjPopupView_Confirm:(id)sender {
    if (self.popupViewDelegate && [self.popupViewDelegate respondsToSelector:@selector(cjPopupView_Confirm:)]) {
        [self.popupViewDelegate cjPopupView_Confirm:self];
    }
    
}

- (IBAction)cjPopupView_Cancel:(id)sender {
    if (self.popupViewDelegate && [self.popupViewDelegate respondsToSelector:@selector(cjPopupView_Cancel:)]) {
        [self.popupViewDelegate cjPopupView_Cancel:self];
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentTextField = textField;
}

///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat mainScreenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat keyboardHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;//获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat maxValidHeight = mainScreenHeight - keyboardHeight - kKeyboardHeightPadding;
    
    //计算"输入框底端"到"键盘顶端"的距离
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect convertFrame = [self convertRect:self.currentTextField.frame toView:keyWindow];
    //CGRect convertFrame = [self.currentTextField convertRect:self.currentTextField.frame toView:keyWindow];//这样转换出来的位置是错误的。。。
    CGFloat offset = CGRectGetMaxY(convertFrame) - maxValidHeight;
    if(offset > 0) {
        double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = self.frame;
            frame.origin.y -= offset;
            self.frame = frame;
            
            self.offset = offset;
        }];
    }
}

///键盘大小改变事件
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    /*
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect beginKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    */
}

///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notification {
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.frame;
        frame.origin.y += self.offset;
        self.frame = frame;
    }];
}

@end
