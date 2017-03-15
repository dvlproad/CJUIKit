//
//  UIScrollView+CJKeyboardAvoiding.m
//  AllScrollViewDemo
//
//  Created by lichq on 8/10/13.
//  Copyright (c) 2013 ciyouzen. All rights reserved.
//

#import "UIScrollView+CJKeyboardAvoiding.h"

static NSString *cjKeyboardAvoidingOffsetKey = @"cjKeyboardAvoidingOffsetKey";

@interface UIScrollView () {
    
}
//@property (nonatomic, assign) CGPoint oldContentOffset;

@end


@implementation UIScrollView (CJKeyboardAvoiding)

#pragma mark - runtime
//cjExtraOffset
- (CGFloat)cjKeyboardAvoidingOffset {
    return [objc_getAssociatedObject(self, &cjKeyboardAvoidingOffsetKey) floatValue];
}

- (void)setCjKeyboardAvoidingOffset:(CGFloat)cjKeyboardAvoidingOffset {
    objc_setAssociatedObject(self, &cjKeyboardAvoidingOffsetKey, @(cjKeyboardAvoidingOffset), OBJC_ASSOCIATION_ASSIGN);
}


- (void)cj_registerKeyboardNotifications {
    self.cjKeyboardAvoidingOffset = 20;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)cj_unRegisterKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    [firstResponder resignFirstResponder];
    
    [super touchesEnded:touches withEvent:event];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    if ( !firstResponder ) {
        //No child view is the first responder - nothing to do here
        return;
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDuration:duration];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGRect firstResponderFrameInWindow = [firstResponder convertRect:firstResponder.bounds toView:window];
    CGFloat offset = CGRectGetMinY(endFrame) - CGRectGetMaxY(firstResponderFrameInWindow);
    if (offset < self.cjKeyboardAvoidingOffset) {
        //self.oldContentOffset = self.contentOffset;
        
        CGFloat newOffsetX = self.contentOffset.x;
        CGFloat newOffsetY = self.contentOffset.y - offset + self.cjKeyboardAvoidingOffset;
        [self setContentOffset:CGPointMake(newOffsetX, newOffsetY) animated:YES];
    }
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    //CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDuration:duration];
    
    CGFloat offset = self.contentOffset.y + CGRectGetHeight(self.frame) - self.contentSize.height;
    if (offset > self.cjKeyboardAvoidingOffset) {
        CGFloat newOffsetX = self.contentOffset.x;
        CGFloat newOffsetY = self.contentOffset.y - offset + self.cjKeyboardAvoidingOffset;
        
        [self setContentOffset:CGPointMake(newOffsetX, newOffsetY) animated:YES];
    }
    //[self setContentOffset:self.oldContentOffset animated:YES];
    
    
    [UIView commitAnimations];
}

- (UIView *)findFirstResponderBeneathView:(UIView *)view {
    //Search recursively for first responder
    for ( UIView *subview in view.subviews ) {
        if ( [subview respondsToSelector:@selector(isFirstResponder)] && [subview isFirstResponder] ) {
            return subview;
        }
        
        UIView *result = [self findFirstResponderBeneathView:subview];
        if ( result ) {
            return result;
        }
    }
    return nil;
}


@end
