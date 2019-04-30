//
//  NSObject+CJSharedInstance.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  [objective-c 单例继承问题](https://segmentfault.com/q/1010000000131782),该文章alloc创建有问题，本类目待修改

#import "NSObject+CJSharedInstance.h"
#import <objc/runtime.h>

@implementation NSObject (CJSharedInstance)

+ (instancetype)cjSharedInstance {
    id sharedInstance = objc_getAssociatedObject(self, @"cjSharedInstance");
    if (!sharedInstance) {
        sharedInstance = [[[self class] alloc] init];
        objc_setAssociatedObject(self, @"cjSharedInstance", sharedInstance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return sharedInstance;
}

@end
