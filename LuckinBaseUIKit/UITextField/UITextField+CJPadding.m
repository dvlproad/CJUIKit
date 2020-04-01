//
//  UITextField+CJPadding.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextField+CJPadding.h"

@implementation UITextField (CJPadding)

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

///设置 UITextField 的上内边距
- (void)cj_setPaddingTop:(CGFloat)paddingTop {
    [self setValue:[NSNumber numberWithFloat:paddingTop] forKey:@"paddingTop"];
}

///设置 UITextField 的左内边距
- (void)cj_setPaddingLeft:(CGFloat)paddingLeft {
    [self setValue:[NSNumber numberWithFloat:paddingLeft] forKey:@"paddingLeft"];
}

///设置 UITextField 的下内边距
- (void)cj_setPaddingBottom:(CGFloat)paddingBottom {
    [self setValue:[NSNumber numberWithFloat:paddingBottom] forKey:@"paddingBottom"];
}

///设置 UITextField 的右边距
- (void)cj_setPaddingRight:(CGFloat)paddingRight {
    [self setValue:[NSNumber numberWithFloat:paddingRight] forKey:@"paddingRight"];
}


///设置 UITextField 的内边距
- (void)cj_setPaddingEdge:(UIEdgeInsets)paddingEdge {
    [self setValue:[NSNumber numberWithFloat:paddingEdge.top] forKey:@"paddingTop"];
    [self setValue:[NSNumber numberWithFloat:paddingEdge.left] forKey:@"paddingLeft"];
    [self setValue:[NSNumber numberWithFloat:paddingEdge.bottom] forKey:@"paddingBottom"];
    [self setValue:[NSNumber numberWithFloat:paddingEdge.right] forKey:@"paddingRight"];
}

@end
