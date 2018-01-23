//
//  CJKeyboardUtil.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2017/1/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJKeyboardUtil.h"

@implementation CJKeyboardUtil

- (void)registerKeyboardNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self
                      selector:@selector(chatKeyboardWillChangeFrame:)
                          name:UIKeyboardWillChangeFrameNotification
                        object:nil];
    
//    [defaultCenter addObserver:self
//                      selector:@selector(keyboardShow:)
//                          name:UIKeyboardWillShowNotification
//                        object:nil];
//
//    [defaultCenter addObserver:self
//                      selector:@selector(keyboardHide:)
//                          name:UIKeyboardWillHideNotification
//                        object:nil];
}

- (void)unregisterKeyboardNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter removeObserver:self
                             name:UIKeyboardWillChangeFrameNotification
                           object:nil];
    
//    [defaultCenter removeObserver:self
//                             name:UIKeyboardWillShowNotification
//                           object:nil];
//
//    [defaultCenter removeObserver:self
//                             name:UIKeyboardWillHideNotification
//                           object:nil];
}

//- (void)keyboardShow:(NSNotification *)notification {
//    NSLog(@"keyboardShow");
//}
//
//- (void)keyboardHide:(NSNotification *)notification {
//    NSLog(@"keyboardHide");
//}



#pragma mark - UIKeyboardNotification
- (void)chatKeyboardWillChangeFrame:(NSNotification *)notification
{
    NSAssert(self.keyboardWillChangeFrameBlock != nil, @"请设置");
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    
    
    void(^animations)(void) = ^{
        if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height) {//弹出键盘
            CGFloat keyboardHeight = endFrame.size.height;
            self.keyboardWillChangeFrameBlock(keyboardHeight);
        }
        else if (endFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)//关闭键盘(有可能只是切换到其他模式)
        {
            CGFloat keyboardHeight = 0;
            self.keyboardWillChangeFrameBlock(keyboardHeight);
        }
        else
        {
            CGFloat keyboardHeight = endFrame.size.height;
            self.keyboardWillChangeFrameBlock(keyboardHeight);
        }
    };
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState)
                     animations:animations
                     completion:nil];
}

@end
