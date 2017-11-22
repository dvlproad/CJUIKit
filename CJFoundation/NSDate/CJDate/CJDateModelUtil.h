//
//  CJDateModelUtil.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 15/4/9.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDateModel.h"

@interface CJDateModelUtil : NSObject

/**
 *  获取从开始日期到计算日期之间所有CJDateModel
 *
 *  @param fromDate     开始日期
 *  @param toDate       结束日期
 */
- (NSMutableArray<CJDateModel *> *)findAllCJDateModelFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
