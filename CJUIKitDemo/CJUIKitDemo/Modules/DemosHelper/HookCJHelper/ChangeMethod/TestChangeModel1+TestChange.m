//
//  TestChangeModel1+TestChange.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestChangeModel1+TestChange.h"

NSString *const TestChangeModel1_sameMethod = @"TestChangeModel1_sameMethod";

@implementation TestChangeModel1 (TestChange)

- (NSString *)common_swizzle_printLog {
    return TestChangeModel1_sameMethod;
}

@end
