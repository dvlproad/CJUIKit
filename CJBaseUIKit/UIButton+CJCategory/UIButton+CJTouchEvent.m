//
//  UIButton+CJTouchEvent.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "UIButton+CJTouchEvent.h"
#import <objc/runtime.h>

@implementation UIButton (CJTouchEvent)

#pragma mark - runtime
static NSString * const cjTouchEventBlockKey = @"cjTouchEventBlockKey";

- (void (^)(UIButton *))cjTouchEventBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cjTouchEventBlockKey));
}

- (void)setCjTouchEventBlock:(void (^)(UIButton *))cjTouchEventBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cjTouchEventBlockKey), cjTouchEventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //设置的时候，就给他添加方法，省得再多个接口处理
    [self addTarget:self action:@selector(cjTouchEventAction:) forControlEvents:UIControlEventTouchUpInside];
}

// 按钮点击
- (void)cjTouchEventAction:(UIButton *)button {
    if (self.cjTouchEventBlock) {
        self.cjTouchEventBlock(button);
    }
}

@end
