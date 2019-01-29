//
//  TestHookModel2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestHookModel2.h"

@implementation TestHookModel2

NSString *const TestHookModel2_sameMethod = @"TestHookModel2_sameMethod";
NSString *const TestHookModel2_diffMethod = @"TestHookModel2_diffMethod";

- (NSString *)common_swizzle_printLog {
    return TestHookModel2_sameMethod;
}

- (NSString *)model2_swizzle_printLog {
    return TestHookModel2_diffMethod;
}


@end
