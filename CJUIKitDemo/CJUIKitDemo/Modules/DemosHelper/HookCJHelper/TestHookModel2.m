//
//  TestHookModel2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestHookModel2.h"

@implementation TestHookModel2

NSString *const hook_TestHookModel2 = @"swizzle_printLog in TestHookModel2";

- (NSString *)swizzle_printLog {
    return hook_TestHookModel2;
}

@end
