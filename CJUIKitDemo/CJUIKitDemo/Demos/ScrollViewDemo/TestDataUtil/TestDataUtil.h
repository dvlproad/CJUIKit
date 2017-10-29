//
//  TestDataUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJSectionDataModel.h"
#import "TestDataModel.h"

@interface TestDataUtil : NSObject

+ (NSMutableArray<TestDataModel *> *)getTestDataModels;

/** 提供测试数据给OpenCollectionViewController */
+ (NSMutableArray<CJSectionDataModel *> *)getTestSectionDataModels;

/** 提供测试数据给DemoTableViewController */
+ (NSMutableArray<CJSectionDataModel *> *)testDataForDemoTableViewController;

@end
