//
//  UITextField+CJTextChangeBlock.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextField+CJTextChangeBlock.h"
#import <objc/runtime.h>

@implementation UITextField (CJTextChangeBlock)

#pragma mark - runtime
static NSString *cjTextDidChangeBlockKey = @"cjTextDidChangeBlockKey";

- (void (^)(UITextField *))cjTextDidChangeBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cjTextDidChangeBlockKey));
}

- (void)setCjTextDidChangeBlock:(void (^)(UITextField *))cjTextDidChangeBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cjTextDidChangeBlockKey), cjTextDidChangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //①KVO方式：为了检测通过代码textField.text = newValue赋值时，文本内容的变化
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    //②直接添加监视
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //③注册消息通知
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self]; //addObserver:self 监听者对象;object 监听的对象 全部监听用nil, 单个监听填_textField自己即self
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}


/**
 *  文本内容改变的事件
 */
- (void)textFieldDidChange:(UITextField *)textField {
    if (self.cjTextDidChangeBlock) {
        self.cjTextDidChangeBlock(textField);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([@"text" isEqualToString:keyPath]) {
        if ([object isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)object;
            
            if (self.cjTextDidChangeBlock) {
                self.cjTextDidChangeBlock(textField);
            }
        }
    }
}



@end
