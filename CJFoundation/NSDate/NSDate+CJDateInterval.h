//
//  NSDate+CJDateInterval.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/7/4.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  两个日期的间隔计算(得到dateInterval)
 */
@interface NSDate (CJDateInterval)

/**
 *  计算从fromDate到toDate，两个时间的单位差（附：如果是计算总共有多少单位则还需要加1）
 *
 *  @param fromDate         计算的开始时间
 *  @param toDate           计算的结束时间
 *  @param calculateUnit    计算的单位
 *
 *  return 返回相差有多少单位
 */
+ (NSInteger)cj_dateIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate inCalculateUnit:(NSCalendarUnit)calculateUnit;
//附系统的是实例方法 - (NSTimeInterval)timeIntervalSinceDate:(NSDate *)anotherDate;


/**
 *  计算从fromDate到toDate，两个时间的年龄差
 *
 *  @param fromDate         计算的开始时间
 *  @param toDate           计算的结束时间
 *
 *  return 返回相差有多少年龄(年)
 */
+ (NSInteger)cj_ageIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
