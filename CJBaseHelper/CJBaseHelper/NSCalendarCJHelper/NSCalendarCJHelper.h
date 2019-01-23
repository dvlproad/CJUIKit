//
//  NSCalendarCJHelper.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/14.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDateModel.h"

@interface NSCalendarCJHelper : NSObject



#pragma mark - DateJudge
///是否为同一天
+ (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2;


#pragma mark - DateValue
/// 获取该日期是星期几
FOUNDATION_EXTERN NSString *NSCalendarCJHelper_weekdayString(NSDate *date);



#pragma mark - 计算两个日期的时间差(返回值 NSInteger)
/// 计算从fromDate到toDate，两个时间的单位差（附：如果是计算总共有多少单位则还需要加1）(C函数)
FOUNDATION_EXTERN NSInteger NSCalendarCJHelper_unitInterval(NSDate *fromDate, NSDate *toDate, NSCalendarUnit calculateUnit);

/// 计算两个时间，相差的年数
FOUNDATION_EXTERN NSInteger NSCalendarCJHelper_yearInterval(NSDate *fromDate, NSDate *toDate);
/// 计算两个时间，相差的月数
FOUNDATION_EXTERN NSInteger NSCalendarCJHelper_monthInterval(NSDate *fromDate, NSDate *toDate);
/// 计算两个时间，相差的天数
FOUNDATION_EXTERN NSInteger NSCalendarCJHelper_dayInterval(NSDate *fromDate, NSDate *toDate);

/// 计算从birthdayDate到现在的年龄(nominalAge是否虚岁)
FOUNDATION_EXTERN NSInteger NSCalendarCJHelper_age(NSDate *birthdayDate, BOOL nominalAge);


#pragma mark - 获取指定日期所在周/月的第一天和最后一天(返回值NSDate)

/// 获取指定日期所在周的第一天(isChinese为NO时,周日为第一天)
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_weekBeginDate(NSDate *date, BOOL isChinese);
/// 获取指定日期所在周的最后一天(isChinese为NO时,周六为最后一天)
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_weekLastDate(NSDate *date, BOOL isChinese);

/// 获取指定日期所在月的第一天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_monthBeginDate(NSDate *date);
/// 获取指定日期所在月的最后一天
FOUNDATION_EXTERN NSDate *NSCalendarCJHelper_monthLastDate(NSDate *date);



#pragma mark - 获取与指定日期间隔多少单位的日期(返回值NSDate)

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


#pragma mark - 获取从指定开始日期到指定结束日期之间所有日期模型(返回值NSMutableArray<CJDateModel *> *)
/**
 *  获取从指定开始日期到指定结束日期之间所有日期模型CJDateModel
 *
 *  @param dateBegin    开始日期
 *  @param dateEnd      结束日期
 */
FOUNDATION_EXTERN NSMutableArray<CJDateModel *> *NSCalendarCJHelper_allCJDateModels(NSDate *dateBegin, NSDate *dateEnd);

@end
