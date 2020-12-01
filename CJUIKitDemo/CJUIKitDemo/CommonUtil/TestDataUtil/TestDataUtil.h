//
//  TestDataUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "CQDMSectionDataModel.h"
#import "TestDataModel.h"

@interface TestDataUtil : NSObject

/** 提供测试数据给OpenCollectionViewController */
+ (NSMutableArray<CQDMSectionDataModel *> *)getTestSectionDataModels;

/** 提供测试数据给BaseTableViewCellViewController */
+ (NSMutableArray<CQDMSectionDataModel *> *)testDataForDemoTableViewController;

@end
