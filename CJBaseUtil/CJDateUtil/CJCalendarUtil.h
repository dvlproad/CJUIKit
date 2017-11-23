//
//  CJCalendarUtil.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/14.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJCalendarUtil : NSObject

/**
 *  该日期是星期几
 */
+ (NSString *)weekday_stringFromDate:(NSDate *)date;



#pragma mark - unitIntervalFromDate
+ (NSInteger)year_unitIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSInteger)month_unitIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSInteger)day_unitIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 *  计算从fromDate到toDate，两个时间的单位差（附：如果是计算总共有多少单位则还需要加1）
 *
 *  @param fromDate         计算的开始时间
 *  @param toDate           计算的结束时间
 *  @param calculateUnit    计算的单位
 *
 *  return 返回相差有多少单位
 */
+ (NSInteger)unitIntervalFromDate:(NSDate *)fromDate
                           toDate:(NSDate *)toDate
                  inCalculateUnit:(NSCalendarUnit)calculateUnit;
//附系统的是实例方法 - (NSTimeInterval)timeIntervalSinceDate:(NSDate *)anotherDate;


/**
 *  计算从fromDate到toDate，两个时间的年龄差
 *
 *  @param fromDate         计算的开始时间
 *  @param toDate           计算的结束时间
 *
 *  return 返回相差有多少年龄(年)
 */
+ (NSInteger)age_unitIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;


#pragma mark - dateFromUnitInterval:计算与指定日期间隔多少单位的日期

+ (NSDate *)yesterday_dateFromSinceDate:(NSDate *)sinceDate;

+ (NSDate *)tomorrow_dateFromSinceDate:(NSDate *)sinceDate;

/**
 *  获取距离本日期多少个“天”单位的日期
 *
 *  @param unitInterval     多少个单位
 *  @param sinceDate        从什么日期开始算
 *
 *  @return 计算得出的日期
 */
+ (NSDate *)dateFromDayUnitInterval:(NSInteger )unitInterval sinceDate:(NSDate *)sinceDate;

/**
 *  获取距离本日期多少个单位的日期
 *
 *  @param unitInterval     多少个单位
 *  @param calculateUnit    计算的单位
 *  @param sinceDate        从什么日期开始算
 *
 *  @return 计算得出的日期
 */
+ (NSDate *)dateFromUnitInterval:(NSInteger )unitInterval calculateUnit:(NSCalendarUnit)calculateUnit sinceDate:(NSDate *)sinceDate;
//附：系统为+ (instancetype)dateWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDate:(NSDate *)date;

@end
