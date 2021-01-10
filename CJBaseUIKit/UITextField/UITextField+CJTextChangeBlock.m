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
static NSString * const cjTextDidChangeBlockKey = @"cjTextDidChangeBlockKey";

- (void (^)(UITextField *bTextField))cjTextDidChangeBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cjTextDidChangeBlockKey));
}

- (void)setCjTextDidChangeBlock:(void (^)(UITextField *bTextField))cjTextDidChangeBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cjTextDidChangeBlockKey), cjTextDidChangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //①KVO方式：为了检测通过代码textField.text = newValue赋值时，文本内容的变化
//    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];   // 使用此方式，会导致当执行[self.view endEditing:YES];时候崩溃，比如在touchesBegan执行
    
    //②直接添加监视
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //③注册消息通知
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self]; //addObserver:self 监听者对象;object 监听的对象 全部监听用nil, 单个监听填_textField自己即self
}

//重点注意(这个问题当初排查了将近三天)：即使dealloc里面是空的，也不能在这边重写该方法，否则容易引起iOS8上的UITextField textInputView message sent to deallocated instance问题，即使你发现你根本没引用到这个类。[UITextField textInputView message sent to deallocated instance](https://stackoverflow.com/questions/35715601/uitextfield-textinputview-message-sent-to-deallocated-instance)
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
//}


/**
 *  文本内容改变的事件
 */
- (void)textFieldDidChange:(UITextField *)textField {
//    // 过滤空格
//    NSString *text = [[textField.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
//    textField.text = text;
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
