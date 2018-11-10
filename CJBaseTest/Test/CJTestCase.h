//
//  CJTestCase.h
//  CJUIKitDemoTests
//
//  Created by ciyouzen on 2017/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <XCTest/XCTest.h>

#define CJ_WAIT_TEST do {\
[self expectationForNotification:@"CJTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:30 handler:nil];\
} while (0);

#define CJ_NOTIFY_TEST \
[[NSNotificationCenter defaultCenter]postNotificationName:@"CJTest" object:nil];

@interface CJTestCase : XCTestCase

@end
