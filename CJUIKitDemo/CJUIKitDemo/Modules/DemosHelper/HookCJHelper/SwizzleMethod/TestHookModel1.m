//
//  TestHookModel1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestHookModel1.h"

NSString *const TestHookModel1_originMethod = @"TestHookModel1_originMethod";

@implementation TestHookModel1

- (NSString *)printLog {
    return TestHookModel1_originMethod;
}

@end
