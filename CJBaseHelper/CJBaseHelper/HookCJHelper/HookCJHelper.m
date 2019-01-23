//
//  HookCJHelper.m
//  CJBaseHelperDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HookCJHelper.h"

@implementation HookCJHelper

/// hook class的originalSelector为swizzledSelector
void HookCJHelper_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    //注：判断条件不能少,否则非常容易出现崩溃
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //添加成功了,说明本类中不存在swizzledMethod所以此时必须将swizzledMethod的实现指针换成originalSelector的,否则swizzledMethod将没有实现。
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        //添加失败了,说明本类中有swizzledMethod的实现,此时只需要将originalMethod和swizzledMethod的IMP互换一下即可。
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
