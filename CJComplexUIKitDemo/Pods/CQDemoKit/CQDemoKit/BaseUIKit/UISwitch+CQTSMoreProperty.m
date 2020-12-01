//
//  UISwitch+CQTSMoreProperty.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "UISwitch+CQTSMoreProperty.h"
#import <objc/runtime.h>

static NSString * const cqtsValueChangedBlockKey = @"cqtsValueChangedBlockKey";

@implementation UISwitch (CQTSMoreProperty)

#pragma mark - runtime

// cqtsValueChangedBlock
- (void (^)(UISwitch *))cqtsValueChangedBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(cqtsValueChangedBlockKey));
}

- (void)setCqtsValueChangedBlock:(void (^)(UISwitch *))cqtsValueChangedBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(cqtsValueChangedBlockKey), cqtsValueChangedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //设置的时候，就给他添加方法，省得再多个接口处理
    [self addTarget:self action:@selector(__cqtsValueChangedAction:) forControlEvents:(UIControlEventValueChanged)];
}


#pragma mark - Private Method
// switch开关值变化时候的回调事件
- (void)__cqtsValueChangedAction:(UISwitch *)mSwitch {
    if (self.cqtsValueChangedBlock) {
        self.cqtsValueChangedBlock(mSwitch);
    }
}

@end
