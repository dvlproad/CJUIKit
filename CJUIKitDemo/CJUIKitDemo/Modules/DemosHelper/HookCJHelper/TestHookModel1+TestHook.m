//
//  TestHookModel1+TestHook.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestHookModel1+TestHook.h"

NSString *const hook_TestHookModel1 = @"swizzle_printLog in TestHookModel1";

@implementation TestHookModel1 (TestHook)

- (NSString *)swizzle_printLog {
    return hook_TestHookModel1;
}

@end
