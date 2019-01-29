//
//  TestHookModel1+TestHook.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestHookModel1+TestHook.h"

NSString *const TestHookModel1_sameMethod = @"TestHookModel1_sameMethod";

@implementation TestHookModel1 (TestHook)

- (NSString *)common_swizzle_printLog {
    return TestHookModel1_sameMethod;
}

@end
