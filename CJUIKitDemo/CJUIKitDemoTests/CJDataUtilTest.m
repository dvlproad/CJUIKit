//
//  CJDataUtilTest.m
//  CJUIKitDemoTests
//
//  Created by lichq on 2018/5/30.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CJDataUtil+SortOrder.h"
#import "CJPinyinHelper.h"

#import "TestCityModel.h"

@interface CJDataUtilTest : XCTestCase

@end

@implementation CJDataUtilTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

///拼音--正常情况
- (void)testPinyinHelper {
    NSString *pinyinString = [CJPinyinHelper pinyinFromChineseString:@"重庆"];
    BOOL isEqual = [pinyinString isEqualToString:@"zhongqing"];
    XCTAssert(isEqual);
}

///拼音--地点情况
- (void)testPinyinHelperForPlace {
    NSString *pinyinString = [CJPinyinHelper placePinyinFromChineseString:@"重庆"];
    BOOL isEqual = [pinyinString isEqualToString:@"chongqing"];
    XCTAssert(isEqual);
}

///排序--字符串
- (void)testSortOrderForString {
    NSArray *originDataArray = @[@"北京", @"上海", @"广州", @"深圳", @"重庆", @"厦门"];
    NSArray *targetDataArray = @[@"北京", @"重庆", @"广州", @"上海", @"深圳", @"厦门"];
    
    NSArray *newDataArray = [CJDataUtil sortOrderInDataArray:originDataArray withDataSelector:nil pinyinFromStringBlock:^NSString *(NSString *string) {
        NSString *pinyinString = [CJPinyinHelper placePinyinFromChineseString:string];
        return pinyinString;
    }];
    BOOL isEqual = [newDataArray isEqualToArray:targetDataArray];
    XCTAssert(isEqual);
}

///排序--对象模型
- (void)testSortOrderForModel {
    TestCityModel *beijingCityModel = [[TestCityModel alloc] init];
    beijingCityModel.name = @"北京";
    
    TestCityModel *shanghaiCityModel = [[TestCityModel alloc] init];
    shanghaiCityModel.name = @"上海";
    
    TestCityModel *guangzhouCityModel = [[TestCityModel alloc] init];
    guangzhouCityModel.name = @"广州";
    
    TestCityModel *shenzhenCityModel = [[TestCityModel alloc] init];
    shenzhenCityModel.name = @"深圳";
    
    TestCityModel *chongqingCityModel = [[TestCityModel alloc] init];
    chongqingCityModel.name = @"重庆";
    
    TestCityModel *xiamenCityModel = [[TestCityModel alloc] init];
    xiamenCityModel.name = @"厦门";
    
    
    NSArray *originDataArray = @[beijingCityModel,
                                 shanghaiCityModel,
                                 guangzhouCityModel,
                                 shenzhenCityModel,
                                 chongqingCityModel,
                                 xiamenCityModel,
                                 ];
    NSArray *targetDataArray = @[beijingCityModel,
                                 chongqingCityModel,
                                 guangzhouCityModel,
                                 shanghaiCityModel,
                                 shenzhenCityModel,
                                 xiamenCityModel,
                                 ];
    
    NSArray *newDataArray = [CJDataUtil sortOrderInDataArray:originDataArray withDataSelector:@selector(name) pinyinFromStringBlock:^NSString *(NSString *string) {
        NSString *pinyinString = [CJPinyinHelper placePinyinFromChineseString:string];
        return pinyinString;
    }];
    NSInteger count = originDataArray.count;
    for (NSInteger i = 0; i < count; i++) {
        TestCityModel *cityModel1 = [newDataArray objectAtIndex:i];
        TestCityModel *cityModel2 = [targetDataArray objectAtIndex:i];
        if (![cityModel1.name isEqualToString:cityModel2.name]) {
            XCTAssert(NO);
            break;
        }
    }
}

@end
