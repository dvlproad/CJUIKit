//
//  CJTextField.m
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTextField.h"

@implementation CJTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addTarget:self action:@selector(textFieldClickAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldClickAction {
    NSLog(@"textFieldClickAction");
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setTextChangeBlock:(void (^)(CJTextField *))textChangeBlock {
    _textChangeBlock = textChangeBlock;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

/**
 *  文本改变的通知事件
 */
- (void)textChange {
    if (self.textChangeBlock) {
        self.textChangeBlock(self);
    }
}

/**
 *  是否隐藏光标
 *
 *  @param hideCursor   是否隐藏光标
 */
- (void)setHideCursor:(BOOL)hideCursor {
    _hideCursor = hideCursor;
    
    self.tintColor = [UIColor clearColor];  //隐藏光标
}

//通过实现UIResponse的- (BOOL)canPerformAction: withSender:方法来去除双击时的弹出框
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.hideMenuController) {
        if ([UIMenuController sharedMenuController]) {
            [UIMenuController sharedMenuController].menuVisible = NO;
        }
        return NO;
    }
    
    return YES; //TODO:选则弹出选项的删除操作会崩溃
}


@end
