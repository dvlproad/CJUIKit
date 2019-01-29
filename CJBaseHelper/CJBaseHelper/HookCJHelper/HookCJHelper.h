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
void HookCJHelper_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

/**
 *  change originalSelOwnerClass的originalSelector 为 swizzledSelOwnerClass的swizzledSelector
 *  @brief  注:
 ①只会将originalSelOwnerClass的originalSelector实现 改为 swizzledSelOwnerClass的swizzledSelector的实现，不会将swizzledSelOwnerClass的swizzledSelector 改为 originalSelOwnerClass的originalSelector 的实现；
 ②swizzledSelOwnerClass和originalSelOwnerClass可以为同一个类；
 *
 *  @param originalSelOwnerClass    要修改的类
 *  @param originalSelector         要修改的方法
 *  @param swizzledSelOwnerClass    要修改成的方法所在的类
 *  @param swizzledSelector         修改成那个类里面的方法
 */
void HookCJHelper_changeMethod(Class originalSelOwnerClass, SEL originalSelector, Class swizzledSelOwnerClass, SEL swizzledSelector);

@end
