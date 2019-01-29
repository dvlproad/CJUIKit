//
//  TestHookModel1+TestHook.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestHookModel1.h"

UIKIT_EXTERN NSString *const TestHookModel1_sameMethod;

@interface TestHookModel1 (TestHook)

- (NSString *)common_swizzle_printLog;

@end
