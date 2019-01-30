//
//  HookCJHelper.m
//  CJBaseHelperDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HookCJHelper.h"

@implementation HookCJHelper

#pragma mark - the swizzle which Can recover originalMethod
/// swizzle class's originalSelector to swizzledSelector
void HookCJHelper_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL swizzMethodIsNewMethodForThisClass =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    if (swizzMethodIsNewMethodForThisClass) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        // add failure meaning the class has exist swizzledMethod, so we just need exchange the originalMethod's IMP to swizzledMethod's IMP.
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/**
 *  exchange class1's method to class2's method (can recover originalMethod)
 *  @brief      add swizzledSelOwnerClass's swizzledSelector method to originalSelOwnerClass, and make originalSelector method's imp is swizzledSelector's imp
 *  @attention  swizzledSelOwnerClass and originalSelOwnerClass shouldn't same;
 *
 *  @param originalSelOwnerClass    the class which will add swizzledMethod, and exchangeImp between originalMethod and swizzledMethod
 *  @param originalSelector         the method which will be exchange
 *  @param swizzledSelOwnerClass    the new method owner class
 *  @param swizzledSelector         the method which will be add for class1, which is in class2
 *
 *  @return is add and exchange Success
 */
bool HookCJHelper_addAndExchangeMethodFromDiffClass(Class originalSelOwnerClass, SEL originalSelector, Class swizzledSelOwnerClass, SEL swizzledSelector) {
    NSString *class1String = NSStringFromClass(originalSelOwnerClass);
    NSString *class2String = NSStringFromClass(swizzledSelOwnerClass);
    if ([class1String isEqualToString:class2String]) {
        NSLog(@"Error:the two class should be difference");
        return false;
    }
    
    Method originalMethod = class_getInstanceMethod(originalSelOwnerClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledSelOwnerClass, swizzledSelector);
    // demand:exchange the class1's originalMethod to class1's newMethod, but the newMethod can't implemente in class1
    // problem analysis: because of apple system doesn't give WKFileUploadPanel class, so we can't implemente and add the new method for it, directly. So
    // step1: we implemente the new method in other class at first, for example UIImagePickerController class. Then we add the class2's new method for the class1.
    // step2: exchange the class1's originalMethod to class1's newMethod
    
    // eg1:
    // decription: add `diff_change_printLog` method for `TestChangeModel1` class
    // originalSelOwnerClass:TestChangeModel1 just exist printLog and common_change_printLog method
    // swizzledMethod:diff_change_printLog
    // eg2:
    // decription: add `swizzled_imagePickerController:didFinishPickingMediaWithInfo:` method for `WKFileUploadPanel` class
    // originalSelOwnerClass:NSClassFromString(@"WKFileUploadPanel") just exist `imagePickerController:didFinishPickingMediaWithInfo:`
    // swizzledMethod:swizzled_imagePickerController:didFinishPickingMediaWithInfo:
    
    // if originalClass doesn't exist swizzledSelector, add it
    BOOL swizzMethodIsNewMethodForOriClass =
    class_addMethod(originalSelOwnerClass,
                    swizzledSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    // if swizzMethod is new method for OriClass before, then the above method will add swizzMethod for OriClass and return YES, else it will return NO;
    // eg: UIImagePickerController class doesn't exist method2, then add it to UIImagePickerController class;
    // eg: now UIImagePickerController exist method1 and method2
    
    // swizzledSelOwnerClass:NSClassFromString(@"WKFileUploadPanel")
    // originalMethod:imagePickerController:didFinishPickingMediaWithInfo:
    
    // then: change UIImagePickerController method2 to method1
    if (swizzMethodIsNewMethodForOriClass) {
        Method swizzledMethod2 = class_getInstanceMethod(originalSelOwnerClass, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod2);
        return true;
    }
    
    NSLog(@"Error:the class1 has exist implemete or added the method, please use new method name for your method which you want to add to class1 from class2");
    return false;
}


#pragma mark - the swizzle which Can't recover originalMethod and will lose it
/**
 *  replace method (can't recover originalMethod, will lose it)
 *  @brief replace originalSelector method's imp to swizzledSelector's imp
 *  @attention swizzledSelOwnerClass and originalSelOwnerClass allow to be same;
 *
 *  @param originalSelOwnerClass    the class which will replace originalSelector method's imp to swizzledSelector's imp
 *  @param originalSelector         the method which will be replace
 *  @param swizzledSelOwnerClass    the replace method owner class
 *  @param swizzledSelector         the replace method
 *
 *  @return is replaceMethod Success
 */
bool HookCJHelper_replaceMethod(Class originalSelOwnerClass, SEL originalSelector, Class swizzledSelOwnerClass, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalSelOwnerClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledSelOwnerClass, swizzledSelector);
    if (!originalMethod) {
        NSLog(@"Error:the originalSelOwnerClass's originalMethod doesn't exist");
        return false;
    }
    
    if (!swizzledMethod) {
        NSLog(@"Error:the swizzledSelOwnerClass's swizzledMethod doesn't exist");
        return false;
    }
    
    class_replaceMethod(originalSelOwnerClass,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
    
    return true;
}


@end
