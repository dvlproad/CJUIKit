//
//  NSDate+CJExtendedDate.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/14.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  间隔多少单位的日期计算(得到Date)
 */
@interface NSDate (CJExtendedDate)

- (NSDate *)cj_yesterday;
- (NSDate *)cj_tomorrow;

/**
 *  获取距离本日期多少个单位的日期
 *
 *  @param unitInterval     多少个单位
 *  @param calculateUnit    计算的单位
 *  @param sinceDate        从什么日期开始算
 *
 *  @return 计算得出的日期
 */
+ (NSDate *)cj_dateWithUnitInterval:(NSInteger )unitInterval calculateUnit:(NSCalendarUnit)calculateUnit sinceDate:(NSDate *)sinceDate;
//附：系统为+ (instancetype)dateWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDate:(NSDate *)date;



@end
