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
void HookCJHelper_swizzleMethodInSameClass(Class class, SEL originalSelector, SEL swizzledSelector) {
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

/*
/// unhook class的originalSelector为swizzledSelector
void HookCJHelper_recoverMethodInSameClass(Class class, SEL originalSelector, SEL swizzledSelector) {
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
//*/

/**
 *  hook originalSelOwnerClass的originalSelector 为 swizzledSelOwnerClass的swizzledSelector
 *
 *  @param originalSelOwnerClass    要修改的类
 *  @param originalSelector         要修改的方法
 *  @param swizzledSelOwnerClass    要修改成的方法所在的类
 *  @param swizzledSelector         修改成那个类里面的方法
 */
void HookCJHelper_swizzleMethodInDiffClass(Class originalSelOwnerClass, SEL originalSelector, Class swizzledSelOwnerClass, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalSelOwnerClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledSelOwnerClass, swizzledSelector);
    
    // if originalClass doesn't exist swizzledSelector, add it
    // eg: UIImagePickerController class doesn't exist ' swizzled_imagePickerController:didFinishPickingMediaWithInfo:' method, then add it to UIImagePickerController class;
    BOOL isOriClassExistSwizzMethod =
    class_addMethod(originalSelOwnerClass,
                    swizzledSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    // eg: now UIImagePickerController exist method1 and method2
    // method1:imagePickerController:didFinishPickingMediaWithInfo:
    // method2:swizzled_imagePickerController:didFinishPickingMediaWithInfo:
    
    // then: change UIImagePickerController method2 to method1
    if (isOriClassExistSwizzMethod) {
        Method swizzledMethod2 = class_getInstanceMethod(originalSelOwnerClass, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod2);
    } else {
        class_replaceMethod(originalSelOwnerClass,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
    }
}



@end
