//
//  NSObjectCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  源码地址:https://github.com/dvlproad/CJUIKit.git
//
//  知识点：判断是否为空字符串，不能通过NSString的实例方法来进行判断。因为实例方法是通过对象调用的，当这个对象为空时调用方法的时候就不会执行。所以以下两个方法，当string = nil的时候，如果调用[string isEmpty]等类似的实例方法，会返回NO，也就无法返回正确的YES值了。
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//判断是否空字符串
//#define cjIsNullString(s)   (!s || [s isEqual:[NSNull null]] || [s isEqualToString:@""])
#define cjIsNullString(s)   ([NSObjectCJHelper isNullForObject:s])
#define cjIsEmptyString(s)  ([NSObjectCJHelper isEmptyForObject:s])


@interface NSObjectCJHelper : NSObject

#pragma mark - C函数
/// 判断对象是否为NULL或nil(C函数)
UIKIT_EXTERN bool isNullObjectCJHelper(id object);
/// 判断对象是否为空(C函数)
UIKIT_EXTERN bool isEmptyObjectCJHelper(id object);

#pragma mark - OC方法
/// 判断对象是否为NULL或nil(OC方法)
+ (BOOL)isNullForObject:(id)object;

/// 判断对象是否为空(OC方法)
+ (BOOL)isEmptyForObject:(id)object;

@end
