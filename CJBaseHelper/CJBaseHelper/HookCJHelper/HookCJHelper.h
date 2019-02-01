//
//  HookCJHelper.h
//  CJBaseHelperDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

enum TheMethodWhichFromDiffClassDealType{
    addAndExchangeOriMethod = 0,
    RecoverOriMethod
};

@interface HookCJHelper : NSObject

#pragma mark - the swizzle which Can recover originalMethod
/// swizzle class's originalSelector to swizzledSelector
void HookCJHelper_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);


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
bool HookCJHelper_replaceMethod(Class originalSelOwnerClass, SEL originalSelector, Class swizzledSelOwnerClass, SEL swizzledSelector);


#pragma mark - Deal New Method Which From Diff Class
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
bool HookCJHelper_exchangeOriMethodToNewMethodWhichAddFromDiffClass(Class originalSelOwnerClass, SEL originalSelector, Class swizzledSelOwnerClass, SEL swizzledSelector);

///recover class1's method to class2's method (can recover originalMethod)
bool HookCJHelper_recoverOriMethodToNewMethodWhichAddFromDiffClass(Class originalSelOwnerClass, SEL originalSelector, Class swizzledSelOwnerClass, SEL swizzledSelector);


@end
