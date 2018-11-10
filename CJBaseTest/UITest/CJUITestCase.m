//
//  CJUITestCase.m
//  CJUIKitDemoUITests
//
//  Created by ciyouzen on 2017/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJUITestCase.h"

@implementation CJUITestCase

- (void)waitElementChangeVisible:(XCUIElement *)element {
    [self waitElement:element untilVisible:!element.exists];
}

- (void)waitElementChangeEnable:(XCUIElement *)element {
    [self waitElement:element untilEnable:!element.hittable];
}

- (void)waitElementChangeValue:(XCUIElement *)element {
    id oldValue = element.value;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"value != %ld", oldValue];
    [self expectationForPredicate:predicate evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)waitElement:(XCUIElement *)element untilVisible:(BOOL)visible {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"exists == %ld", visible ? 1 : 0];
    [self expectationForPredicate:predicate evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        //NSString *message = @"Failed to find \(element) after 10 seconds.";
        //[self recordFailureWithDescription:message inFile:__FILE__ atLine:__LINE__ expected:YES];
    }];
}

- (void)waitElement:(XCUIElement *)element untilEnable:(BOOL)enable {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hittable == %ld", enable ? 1 : 0];
    [self expectationForPredicate:predicate evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)waitElementSwitch:(XCUIElement *)element untilOn:(BOOL)on {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"value == %ld", on ? 1 : 0];
    [self expectationForPredicate:predicate evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
