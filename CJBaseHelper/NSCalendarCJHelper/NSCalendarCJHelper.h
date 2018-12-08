//
//  NSCalendarCJHelper.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/14.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendarCJHelper : NSObject

#pragma mark - C函数

/// 计算从fromDate到toDate，两个时间的单位差（附：如果是计算总共有多少单位则还需要加1）(C函数)
NSInteger dateIntervalNSCalendarCJHelper(NSDate *fromDate, NSDate *toDate, NSCalendarUnit calculateUnit);


#pragma mark - DateJudge
///是否为同一天
+ (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2;


#pragma mark - DateValue
///该日期是星期几
+ (NSString *)weekday_stringFromDate:(NSDate *)date;



#pragma mark - 计算两个日期的时间差(unitIntervalFromDate)
///计算两个时间，相差的年数
+ (NSInteger)year_unitIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

///计算两个时间，相差的月数
+ (NSInteger)month_unitIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

///计算两个时间，相差的天数
+ (NSInteger)day_unitIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 *  计算从fromDate到toDate，两个时间的单位差（附：如果是计算总共有多少单位则还需要加1）(OC方法)
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


#pragma mark - 获取第一天和最后一天

/// 获取指定日期所在周的第一天(周日为第一天)
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_weekBeginDate(NSDate *date);

/// 获取指定日期所在周的最后一天(周六为最后一天)
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_weekLastDate(NSDate *date);



#pragma mark - 获取与指定日期间隔多少单位的日期(dateFromUnitInterval)

/// 指定日期的前一天那天(昨天)
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_yesterday(NSDate *sinceDate);
/// 指定日期的后一天那天(明天)
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_tomorrow(NSDate *sinceDate);

/// 指定日期的上周那天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_lastWeek(NSDate *sinceDate);
/// 指定日期的下周那天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_nextWeek(NSDate *sinceDate);

/// 指定日期的上个月那天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_lastMonth(NSDate *sinceDate);
/// 指定日期的下个月那天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_nextMonth(NSDate *sinceDate);

/// 指定日期的上个季度那天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_lastQuarter(NSDate *sinceDate);
/// 指定日期的下个季度那天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_nextQuarter(NSDate *sinceDate);

/// 指定日期的去年那天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_lastYear(NSDate *sinceDate);
/// 指定日期的明年那天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_nextYear(NSDate *sinceDate);


//指定日期的加上 xxxsToBeAdded 后所得的新日期
/// 指定日期的加上 daysToBeAdded 后的天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_addDays(NSTimeInterval daysToBeAdded, NSDate *sinceDate);
/// 指定日期的加上 monthsToBeAdded 后的月
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_addMonths(NSTimeInterval monthsToBeAdded, NSDate *sinceDate);
/// 指定日期的加上 yearsToBeAdded 后的年
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_addYears(NSTimeInterval yearsToBeAdded, NSDate *sinceDate);

/// 获取距离本日期多少个单位("天"、"月"、"年"等)的日期(C函数)
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_addUnits(NSDate *sinceDate, NSInteger unitInterval, NSCalendarUnit calculateUnit);

/**
 *  获取距离本日期多少个单位("天"、"月"、"年"等)的日期(OC方法)
 *
 *  @param unitInterval     多少个单位
 *  @param calculateUnit    计算的单位
 *  @param sinceDate        从什么日期开始算
 *
 *  @return 计算得出的日期
 */
+ (NSDate *)dateFromUnitInterval:(NSInteger )unitInterval
                   calculateUnit:(NSCalendarUnit)calculateUnit
                       sinceDate:(NSDate *)sinceDate;
//附：系统为+ (instancetype)dateWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDate:(NSDate *)date;

@end
