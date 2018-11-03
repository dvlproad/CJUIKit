//
//  BBXDAreaCodeTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/5/7.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "BBXDAreaCodeTextField.h"

@interface BBXDAreaCodeTextField ()


@end



@implementation BBXDAreaCodeTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];  //#1a1a1a
        
        UILabel *regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 38)];
        regionLabel.font = [UIFont systemFontOfSize:15];
        regionLabel.textColor = [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1];  //#898989
        regionLabel.text = NSLocalizedString(@"国家或地区", nil);
        regionLabel.textAlignment = NSTextAlignmentLeft;
        self.leftView = regionLabel;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        UIImage *image = [UIImage imageNamed:@"signin_icon_open"];
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 5)];
        arrowImageView.image = image;
        self.rightView = arrowImageView;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseRegionEvent)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)chooseRegionEvent {
    [self endEditing:YES];
    if (self.chooseAreaCodeBlock) {
        self.chooseAreaCodeBlock(self);
    }
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
