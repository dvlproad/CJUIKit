//
//  BBXDUserNameTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/5/7.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "BBXDUserNameTextField.h"

@implementation BBXDUserNameTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];  //#1a1a1a
        
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 38)];
        userNameLabel.font = [UIFont systemFontOfSize:15];
        userNameLabel.textColor = [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1];  //#898989
        userNameLabel.text = NSLocalizedString(@"国家或地区", nil);
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        self.leftView = userNameLabel;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

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

@end
