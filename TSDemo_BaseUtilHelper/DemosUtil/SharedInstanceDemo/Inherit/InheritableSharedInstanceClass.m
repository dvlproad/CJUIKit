//
//  InheritableSharedInstanceClass.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "InheritableSharedInstanceClass.h"
#import <objc/runtime.h>

@implementation InheritableSharedInstanceClass

+ (instancetype)sharedInstance {
    id sharedInstance = objc_getAssociatedObject(self, @"InheritableSharedInstance");
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
        objc_setAssociatedObject(self, @"InheritableSharedInstance", sharedInstance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[self class] sharedInstance];
}

@end
