//
//  CJUITestCase.h
//  CJUIKitDemoUITests
//
//  Created by ciyouzen on 2017/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CJUITestCase : XCTestCase

- (void)waitElementChangeVisible:(XCUIElement *)element;
- (void)waitElementChangeEnable:(XCUIElement *)element;
- (void)waitElementChangeValue:(XCUIElement *)element;

- (void)waitElement:(XCUIElement *)element untilVisible:(BOOL)visible;
- (void)waitElement:(XCUIElement *)element untilEnable:(BOOL)enable;
- (void)waitElementSwitch:(XCUIElement *)element untilOn:(BOOL)on;

@end
