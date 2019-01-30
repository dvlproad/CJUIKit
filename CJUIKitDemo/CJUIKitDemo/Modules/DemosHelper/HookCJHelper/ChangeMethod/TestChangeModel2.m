//
//  TestChangeModel2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TestChangeModel2.h"

@implementation TestChangeModel2

NSString *const TestChangeModel2_sameMethod = @"TestChangeModel2_sameMethod";
NSString *const TestChangeModel2_diffMethod = @"TestChangeModel2_diffMethod";

- (NSString *)common_change_printLog {
    return TestChangeModel2_sameMethod;
}

- (NSString *)diff_change_printLog {
    return TestChangeModel2_diffMethod;
}


@end
