//
//  UITextField+CJTextChangeBlock.m
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextField+CJTextChangeBlock.h"
#import <objc/runtime.h>

@implementation UITextField (CJTextChangeBlock)

#pragma mark - runtime
static NSString *cjTextChangeBlockKey = @"cjTextChangeBlockKey";

- (void (^)(UITextField *))cjTextChangeBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cjTextChangeBlockKey));
}

- (void)setCjTextChangeBlock:(void (^)(UITextField *))cjTextChangeBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cjTextChangeBlockKey), cjTextChangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //①KVO方式：为了检测通过代码textField.text = newValue赋值时，文本内容的变化
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    //②直接添加监视
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //③注册消息通知
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}


/**
 *  文本内容改变的事件
 */
- (void)textFieldDidChange:(UITextField *)textField {
    if (self.cjTextChangeBlock) {
        self.cjTextChangeBlock(textField);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([@"text" isEqualToString:keyPath]) {
        if ([object isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)object;
            
            if (self.cjTextChangeBlock) {
                self.cjTextChangeBlock(textField);
            }
        }
    }
}



@end
