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

/// 获取距离本日期多少个单位("天"、"月"、"年"等)的日期(C函数)
NSDate *dateNSCalendarCJHelper(NSDate *sinceDate, NSInteger unitInterval, NSCalendarUnit calculateUnit);


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


#pragma mark - 获取与指定日期间隔多少单位的日期(dateFromUnitInterval)

/// 指定日期的昨天
+ (NSDate *)yesterday_dateFromSinceDate:(NSDate *)sinceDate;
/// 指定日期的明天
+ (NSDate *)tomorrow_dateFromSinceDate:(NSDate *)sinceDate;

/// 指定日期的上个月
+ (NSDate *)lastMonth_dateFromSinceDate:(NSDate *)sinceDate;
/// 指定日期的下个月
+ (NSDate *)nextMonth_dateFromSinceDate:(NSDate *)sinceDate;

/// 指定日期的去年
+ (NSDate *)lastYear_dateFromSinceDate:(NSDate *)sinceDate;
/// 指定日期的明年
+ (NSDate *)nextYear_dateFromSinceDate:(NSDate *)sinceDate;

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
