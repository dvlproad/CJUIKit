//
//  UIImageTestCase.m
//  CJUIKitDemoTests
//
//  Created by ciyouzen on 2019/1/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <LuckinBaseUIKit/UIImage+CJTransformSize.h>

@interface UIImageTestCase : XCTestCase

@end

@implementation UIImageTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLittleCorrectionSize {
    CGSize originSize = CGSizeMake(100, 100);
    CGSize lastSize = [UIImage cj_correctionSize:originSize toLastPossibleSize:CGSizeMake(50, 60) withScaleType:CJScaleTypeAsFarAsPossibleLittle];
    XCTAssert(CGSizeEqualToSize(lastSize, CGSizeMake(50, 50)), @"计算不正确");
}

- (void)testBigCorrectionSize {
    CGSize originSize = CGSizeMake(100, 100);
    CGSize lastSize = [UIImage cj_correctionSize:originSize toLastPossibleSize:CGSizeMake(50, 60) withScaleType:CJScaleTypeAsFarAsPossibleBig];
    XCTAssert(CGSizeEqualToSize(lastSize, CGSizeMake(60, 60)), @"计算不正确");
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
