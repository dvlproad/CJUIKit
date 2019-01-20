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


/* 完整的描述请参见文件头部 */
- (void)addLeftImageWithNormalImage:(UIImage *)normalImage
                      selectedImage:(UIImage *)selectedImage
                          imageSize:(CGSize)imageSize
{
    UIButton *leftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    [leftView setImage:normalImage forState:UIControlStateNormal];
    [leftView setImage:selectedImage forState:UIControlStateSelected];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setLeftButtonSelected:(BOOL)leftButtonSelected {
    _leftButtonSelected = leftButtonSelected;
    
    UIButton *leftButton = (UIButton *)self.leftView;
    if ([leftButton isKindOfClass:[UIButton class]]) {
        [leftButton setSelected:leftButtonSelected];
    }
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
//*/
- (void)addUnderLineWithHeight:(CGFloat)lineHeight color:(UIColor *)lineColor {
    UIView *underline = [[UIView alloc] initWithFrame:CGRectZero];
    underline.backgroundColor = lineColor;
    [self cj_makeView:self addBottomSubView:underline withHeight:lineHeight];
}

- (void)cj_makeView:(UIView *)superView addBottomSubView:(UIView *)subView withHeight:(CGFloat)height {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:height]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
}


@end
