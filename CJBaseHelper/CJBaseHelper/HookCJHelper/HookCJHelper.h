//
//  HookCJHelper.h
//  CJBaseHelperDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface HookCJHelper : NSObject

/// hook class的originalSelector为swizzledSelector
void HookCJHelper_swizzleMethodInSameClass(Class class, SEL originalSelector, SEL swizzledSelector);

///// unhook class的originalSelector为swizzledSelector
//void HookCJHelper_recoverMethodInSameClass(Class class, SEL originalSelector, SEL swizzledSelector);

/**
 *  hook originalSelOwnerClass的originalSelector 为 swizzledSelOwnerClass的swizzledSelector
 *
 *  @param originalSelOwnerClass    要修改的类
 *  @param originalSelector         要修改的方法
 *  @param swizzledSelOwnerClass    要修改成的方法所在的类
 *  @param swizzledSelector         修改成那个类里面的方法
 */
void HookCJHelper_swizzleMethodInDiffClass(Class originalSelOwnerClass, SEL originalSelector, Class swizzledSelOwnerClass, SEL swizzledSelector);

@end
