//
//  CJUIKitDemoUITests.m
//  CJUIKitDemoUITests
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CJUIKitDemoUITests : XCTestCase

@end

@implementation CJUIKitDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    
    /*
    XCUIElement *homeButton = tabBarsQuery.buttons[@"主页"];
    [homeButton tap];
    
    XCUIElement *scrollViewButton = tabBarsQuery.buttons[@"滚动视图"];
    [scrollViewButton tap];
    
    XCUIElement *smallViewButton = tabBarsQuery.buttons[@"基础小视图"];
    [smallViewButton tap];
    
    XCUIElement *cjfoundataionButton = tabBarsQuery.buttons[@"CJFoundataion"];
    [cjfoundataionButton tap];
    */
    XCUIElement *cjutilButton = tabBarsQuery.buttons[@"CJUtil"];
    [cjutilButton tap];
    
    
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"DataUtil"]/*[[".cells.staticTexts[@\"DataUtil\"]",".staticTexts[@\"DataUtil\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [app.buttons[@"转化上面的文字为拼音"] tap];
    
    
    
    
    
}


- (void)testAlert {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"CJUtil"] tap];

    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Alert"]/*[[".cells.staticTexts[@\"Alert\"]",".staticTexts[@\"Alert\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"FlagImage & Title & Message & OK & Cancel"]/*[[".cells.staticTexts[@\"FlagImage & Title & Message & OK & Cancel\"]",".staticTexts[@\"FlagImage & Title & Message & OK & Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [app.buttons[@"允许上车"] tap];

    sleep(2);
    [app.buttons[@"确认"] tap];
}

///测试DebugView
- (void)testDebugView {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"CJUtil"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Alert"]/*[[".cells.staticTexts[@\"Alert\"]",".staticTexts[@\"Alert\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Debug Request(NSDictionary)"]/*[[".cells.staticTexts[@\"Debug Request(NSDictionary)\"]",".staticTexts[@\"Debug Request(NSDictionary)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    sleep(5);
}

@end
