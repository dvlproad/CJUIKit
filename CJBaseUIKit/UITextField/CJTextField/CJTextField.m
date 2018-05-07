//
//  CJTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextField.h"

@implementation CJTextField

- (void)cj_addLeftOffset:(CGFloat)leftOffset {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftOffset, 10)];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)cj_addRightOffset:(CGFloat)rightOffset {
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightOffset, 10)];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x += self.leftViewLeftOffset;
    
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds:bounds];
    rect.origin.x -= self.rightViewRightOffset;
    
    return rect;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x += self.leftViewRightOffset;
    rect.size.width -= self.leftViewRightOffset + self.rightViewLeftOffset;
    
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    rect.origin.x += self.leftViewRightOffset;
    rect.size.width -= self.leftViewRightOffset + self.rightViewLeftOffset;
    
    return rect;
}

#pragma mark - 添加 View 的下划线
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGFloat bottomLineHeight = 0.5;
    CGRect bottomLineRect = CGRectMake(0, CGRectGetHeight(self.frame) - bottomLineHeight, CGRectGetWidth(self.frame), bottomLineHeight);
    
    UIColor *bottomLineColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];  //#ebebeb
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, bottomLineColor.CGColor);
    CGContextFillRect(context, bottomLineRect);
}
*/


@end
