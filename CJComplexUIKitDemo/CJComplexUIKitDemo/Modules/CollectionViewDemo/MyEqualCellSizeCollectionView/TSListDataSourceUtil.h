//
//  TSListDataSourceUtil.h
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJHomeMenuDataModel.h"
#import "CJFilesLookDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSListDataSourceUtil : NSObject

/// 获取测试用的数据
+ (NSMutableArray<CJHomeMenuDataModel *> *)__getTestLookBadgeDataModels;
+ (NSMutableArray<CJFilesLookDataModel *> *)__getTestDataModels;

@end

NS_ASSUME_NONNULL_END
