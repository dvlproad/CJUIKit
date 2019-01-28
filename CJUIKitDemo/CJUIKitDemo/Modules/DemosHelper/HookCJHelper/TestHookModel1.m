//
//  TestHookModel1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestHookModel1.h"

NSString *const unhook_TestHookModel1 = @"printLog in TestHookModel1";

@implementation TestHookModel1

- (NSString *)printLog {
    return unhook_TestHookModel1;
}

@end
