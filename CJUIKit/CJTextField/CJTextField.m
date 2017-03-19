//
//  CJTextField.m
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextField.h"

@implementation CJTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.tintColor = [UIColor clearColor]; //隐藏光标
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)textChange {
    if (self.hasText) {
        self.text = nil;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//去除双击时的复制框
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
        
    }
    return NO;
}


@end
