//
//  UIButton+CQTSMoreProperty.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "UIButton+CQTSMoreProperty.h"
#import <objc/runtime.h>

static NSString * const cqts_touchUpInsideBlockKey = @"cqts_touchUpInsideBlockKey";

@implementation UIButton (CQTSMoreProperty)

#pragma mark - runtime

// cqtsTouchUpInsideBlock
- (void (^)(UIButton *))cqtsTouchUpInsideBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cqts_touchUpInsideBlockKey));
}

- (void)setCqtsTouchUpInsideBlock:(void (^)(UIButton *))cqtsTouchUpInsideBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cqts_touchUpInsideBlockKey), cqtsTouchUpInsideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //设置的时候，就给他添加方法，省得再多个接口处理
    [self addTarget:self action:@selector(__cqtsTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Private Method
// 按钮点击
- (void)__cqtsTouchUpInsideAction:(UIButton *)button {
    if (self.cqtsTouchUpInsideBlock) {
        self.cqtsTouchUpInsideBlock(button);
    }
}

@end
