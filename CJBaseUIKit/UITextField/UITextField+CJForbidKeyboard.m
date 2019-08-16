//
//  UITextField+CJForbidKeyboard.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextField+CJForbidKeyboard.h"
#import <objc/runtime.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "UIView+CJPopupInView.h"
#else
#import <CJBaseUIKit/UIView+CJPopupInView.h>
#endif

@interface UITextField () {
    
}
@property (nonatomic, strong) UIView *cjTextPicker;

@end


@implementation UITextField (CJForbidKeyboard)

#pragma mark - runtime
- (UIView *)cjTextPicker {
    return objc_getAssociatedObject(self, @selector(cjTextPicker));
}

- (void)setCjTextPicker:(UIView *)cjTextPicker {
    objc_setAssociatedObject(self, @selector(cjTextPicker), cjTextPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cjForbidKeyboard {
    return [objc_getAssociatedObject(self, @selector(cjForbidKeyboard)) boolValue];
}

- (void)setCjForbidKeyboard:(BOOL)cjForbidKeyboard {
    objc_setAssociatedObject(self, @selector(cjForbidKeyboard), @(cjForbidKeyboard), OBJC_ASSOCIATION_ASSIGN);
}

/**
 *  禁用文本框的输入，同时设置文本框的文本来源可为textPicker
 *
 *  @param textPicker 文本框的文本来源,其将作为文本框的inputView使用
 */
- (void)cj_forbidKeyboardAndTextPicker:(UIView * _Nullable)textPicker {
    self.cjForbidKeyboard = YES;
    self.tintColor = [UIColor clearColor];
    
    // 防止会出现第三方库如IQKeyboardManager会自动为textField的弹出的inputView键盘添加Toolbar
    UIView *overlayView = [[UIView alloc] init];
    overlayView.backgroundColor = [UIColor clearColor];
    [self cj_makeView:self addSubView:overlayView withEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.cjTextPicker = textPicker;
    
    if (textPicker) {
        overlayView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__handleSingleTap:)];
        singleTapGesture.numberOfTapsRequired = 1;
        singleTapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:singleTapGesture];
    }
}

- (void)__handleSingleTap:(UIGestureRecognizer *)gr {
    CGFloat popupViewHeight = CGRectGetHeight(self.cjTextPicker.frame);
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    __weak typeof(self)weakSelf = self;
    [self.cjTextPicker cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:UIEdgeInsetsZero blankBGColor:blankBGColor showComplete:nil tapBlankComplete:^() {
        [weakSelf.cjTextPicker cj_hidePopupView];
    }];
}

#pragma mark - addSubView
- (void)cj_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}

@end
