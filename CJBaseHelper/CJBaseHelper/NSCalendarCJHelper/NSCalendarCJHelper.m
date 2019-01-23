//
//  NSCalendarCJHelper.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/14.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import "NSCalendarCJHelper.h"

@implementation NSCalendarCJHelper

#pragma mark - DateJudge
/* 完整的描述请参见文件头部 */
+ (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year];
}


#pragma mark - DateValue
/** 完整的描述请参见文件头部 */
NSString *NSCalendarCJHelper_weekdayString(NSDate *date)  {
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:date];
    NSInteger weekday = [dateComponents weekday];
    
    NSArray *weekdayStringArray = @[@"天", @"一", @"二", @"三", @"四", @"五", @"六"];
    NSString *weekdayString = [weekdayStringArray objectAtIndex:weekday-1];//注意：获取到的weekday值是从1到7
    return weekdayString;
}

#pragma mark - 计算两个日期的时间差(返回值 NSInteger)
/** 完整的描述请参见文件头部 */
NSInteger NSCalendarCJHelper_yearInterval(NSDate *fromDate, NSDate *toDate) {
    return NSCalendarCJHelper_unitInterval(fromDate, toDate, NSCalendarUnitYear);
}
/** 完整的描述请参见文件头部 */
NSInteger NSCalendarCJHelper_monthInterval(NSDate *fromDate, NSDate *toDate) {
    return NSCalendarCJHelper_unitInterval(fromDate, toDate, NSCalendarUnitMonth);
}
/** 完整的描述请参见文件头部 */
NSInteger NSCalendarCJHelper_dayInterval(NSDate *fromDate, NSDate *toDate) {
    return NSCalendarCJHelper_unitInterval(fromDate, toDate, NSCalendarUnitDay);
}

/* 完整的描述请参见文件头部 */
NSInteger NSCalendarCJHelper_unitInterval(NSDate *fromDate, NSDate *toDate, NSCalendarUnit calculateUnit) {
    return [NSCalendarCJHelper unitIntervalFromDate:fromDate toDate:toDate inCalculateUnit:calculateUnit];
}

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
                  inCalculateUnit:(NSCalendarUnit)calculateUnit
//附系统的是实例方法 - (NSTimeInterval)timeIntervalSinceDate:(NSDate *)anotherDate;
{
    /*方法①：计算出相差多少秒，再根据秒来计算
    NSTimeInterval timeInterval = [toDate timeIntervalSinceDate:fromDate];
    
    NSInteger count = timeInterval/60/60/24;
    */
    
    ///*方法②：
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:calculateUnit fromDate:fromDate toDate:toDate options:0];
    
    NSInteger count = 0;
    switch (calculateUnit) {
        case NSCalendarUnitDay: {
            count = [components day];
            break;
        }
        case NSCalendarUnitMonth: {
            count = [components month];
            break;
        }
        case NSCalendarUnitYear: {
            count = [components year];
            break;
        }
        case NSCalendarUnitHour: {
            count = [components hour];
            break;
        }
        case NSCalendarUnitMinute: {
            count = [components minute];
            break;
        }
        case NSCalendarUnitSecond: {
            count = [components second];
            break;
        }
            
        default:
            break;
    }
    //*/
    
    return count;
}

NSInteger NSCalendarCJHelper_age(NSDate *birthdayDate, BOOL nominalAge) {
    return [NSCalendarCJHelper age_unitIntervalWithBirthdayDate:birthdayDate nominalAge:nominalAge];
}

/**
 *  计算从fromDate到toDate，两个时间的年龄差
 *
 *  @param birthdayDate 生日
 *  @param nominalAge   是否是虚岁
 *
 *  return 返回相差有多少年龄(年)
 */
+ (NSInteger)age_unitIntervalWithBirthdayDate:(NSDate *)birthdayDate nominalAge:(BOOL)nominalAge {
    NSDate *currentDate = [NSDate date];
    ///*方法①：
    //NSInteger iAge2 = [NSCalendarCJHelper year_unitIntervalFromDate:birthdayDate toDate:currentDate];
    //NSLog(@"方法①计算出的年纪为%zd", iAge2);
    //*/
    
    //方法②：
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:birthdayDate];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    if (!nominalAge) { //计算周岁
        iAge = iAge - 1;
    }
    //NSLog(@"方法②计算出的年纪为%zd", iAge);
    
    return iAge;
}

#pragma mark - 获取指定日期所在周/月的第一天和最后一天(返回值NSDate)

/// 获取指定日期所在周的第一天(isChinese为NO时,周日为第一天)
NSDate *NSCalendarCJHelper_weekBeginDate(NSDate *date, BOOL isChinese) {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    if (isChinese) {
        [calendar setFirstWeekday:2];
    }
    
    NSDate *weekBeginDate = nil;
    NSTimeInterval timeInterval = 0;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&weekBeginDate interval:&timeInterval forDate:date];
    
    return weekBeginDate;
}

/// 获取指定日期所在周的最后一天(isChinese为NO时,周六为最后一天)
NSDate *NSCalendarCJHelper_weekLastDate(NSDate *date, BOOL isChinese) {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    if (isChinese) {
        [calendar setFirstWeekday:2];
    }
    
    NSDate *weekBeginDate = nil;
    NSTimeInterval timeInterval = 0;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&weekBeginDate interval:&timeInterval forDate:date];
    
    NSDate *weekEndDate = [weekBeginDate dateByAddingTimeInterval:timeInterval-1];
    
    return weekEndDate;
}


/// 获取指定日期所在月的第一天
NSDate *NSCalendarCJHelper_monthBeginDate(NSDate *date) {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday fromDate:date];
    [comps setMonth:[comps month]];
    [comps setDay:1];
    NSDate *monthBeginDate = [calendar dateFromComponents:comps];
    
    return monthBeginDate;
}

/// 获取指定日期所在月的最后一天
NSDate *NSCalendarCJHelper_monthLastDate(NSDate *date) {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday fromDate:date];
    [comps setMonth:[comps month] + 1];
    [comps setDay:0];
    NSDate *monthLastDate = [calendar dateFromComponents:comps];
    
    return monthLastDate;
}


#pragma mark - dateFromUnitInterval:计算与指定日期间隔多少单位的日期(返回值NSDate)
/// 指定日期的前一天那天(昨天)
NSDate *NSCalendarCJHelper_yesterday(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, -1, NSCalendarUnitDay);
}
/// 指定日期的后一天那天(明天)
NSDate *NSCalendarCJHelper_tomorrow(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, 1, NSCalendarUnitDay);
}

/// 指定日期的上周那天
NSDate *NSCalendarCJHelper_lastWeek(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, -7, NSCalendarUnitDay);
}
/// 指定日期的下周那天
NSDate *NSCalendarCJHelper_nextWeek(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, 7, NSCalendarUnitDay);
}

/// 指定日期的上个月那天
NSDate *NSCalendarCJHelper_lastMonth(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, -1, NSCalendarUnitMonth);
}
/// 指定日期的下个月那天
NSDate *NSCalendarCJHelper_nextMonth(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, 1, NSCalendarUnitMonth);
}

/// 指定日期的上个季度那天
NSDate *NSCalendarCJHelper_lastQuarter(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, -3, NSCalendarUnitMonth);
}
/// 指定日期的下个季度那天
NSDate *NSCalendarCJHelper_nextQuarter(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, 3, NSCalendarUnitMonth);
}

/// 指定日期的去年那天
NSDate *NSCalendarCJHelper_lastYear(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, -1, NSCalendarUnitYear);
}
/// 指定日期的明年那天
NSDate *NSCalendarCJHelper_nextYear(NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, 1, NSCalendarUnitYear);
}

//指定日期的加上 xxxsToBeAdded 后所得的新日期
/// 指定日期的加上 daysToBeAdded 后的天
NSDate *NSCalendarCJHelper_addDays(NSTimeInterval daysToBeAdded, NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, daysToBeAdded, NSCalendarUnitDay);
}

/// 指定日期的加上 monthsToBeAdded 后的月
 NSDate *NSCalendarCJHelper_addMonths(NSTimeInterval monthsToBeAdded, NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, monthsToBeAdded, NSCalendarUnitMonth);
}

/// 指定日期的加上 yearsToBeAdded 后的年
NSDate *NSCalendarCJHelper_addYears(NSTimeInterval yearsToBeAdded, NSDate *sinceDate) {
    return NSCalendarCJHelper_addUnits(sinceDate, yearsToBeAdded, NSCalendarUnitYear);
}

/// 获取距离本日期多少个单位("天"、"月"、"年"等)的日期(C函数)
NSDate *NSCalendarCJHelper_addUnits(NSDate *sinceDate, NSInteger unitInterval, NSCalendarUnit calculateUnit) {
    return [NSCalendarCJHelper dateFromUnitInterval:unitInterval calculateUnit:calculateUnit sinceDate:sinceDate];
}

/**
 *  获取距离本日期多少个单位("天"、"月"、"年"等)的日期(OC方法)
 *
 *  @param unitInterval     多少个单位
 *  @param calculateUnit    计算的单位
 *  @param sinceDate        从什么日期开始算
 *
 *  @return 计算得出的日期
 */
//附：系统为+ (instancetype)dateWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDate:(NSDate *)date;
+ (NSDate *)dateFromUnitInterval:(NSInteger )unitInterval
                   calculateUnit:(NSCalendarUnit)calculateUnit
                       sinceDate:(NSDate *)sinceDate
{
    //日期转换 年月日
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSAssert(calculateUnit & calendarUnit, @"sorry current doesn't allowThisUnit, please check");
    
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:sinceDate];
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    NSInteger day = [dateComponents day];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    NSInteger second = [dateComponents second];
    //NSLog(@"当前日期的年月日为：%d,%d,%d", year, month, day);
    
    switch (calculateUnit) {
        case NSCalendarUnitDay: {
            day += unitInterval;
            break;
        }
        case NSCalendarUnitMonth: {
            month += unitInterval;
            break;
        }
        case NSCalendarUnitYear: {
            year += unitInterval;
            break;
        }
        case NSCalendarUnitHour: {
            hour += unitInterval;
            break;
        }
        case NSCalendarUnitMinute: {
            minute += unitInterval;
            break;
        }
        case NSCalendarUnitSecond: {
            second += unitInterval;
            break;
        }
            
        default:
            break;
    }
    
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    [dateComponents setHour:hour];
    [dateComponents setMinute:minute];
    [dateComponents setSecond:second];
    
    //NSLog(@"------------------------------------");
    //NSLog(@"originDate    = %@", self);
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    //NSLog(@"计算后newDate  = %@", newDate);
    
    return newDate;
}


#pragma mark - 获取从指定开始日期到指定结束日期之间所有日期模型(返回值NSMutableArray<CJDateModel *> *)

/** 完整的描述请参见文件头部 */
NSMutableArray<CJDateModel *> *NSCalendarCJHelper_allCJDateModels(NSDate *dateBegin, NSDate *dateEnd) {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    // 开始日期
    NSDateComponents *dateComponentsBegin = [calendar components:calendarUnit fromDate:dateBegin];
    
    NSInteger dateBeginYear  = [dateComponentsBegin year];
    NSInteger dateBeginMonth = [dateComponentsBegin month];
    NSInteger dateBeginDay = [dateComponentsBegin day];
    
    // 结束日期
    NSDateComponents *dateComponentsEnd = [calendar components:calendarUnit fromDate:dateEnd];
    
    NSInteger dateEndYear  = [dateComponentsEnd year];
    NSInteger dateEndMonth = [dateComponentsEnd month];
    NSInteger dateEndDay = [dateComponentsEnd day];
    
    // 开始日期与结束日期之间
    NSMutableArray *dateArray = [[NSMutableArray alloc]init];
    NSUInteger dayIndex = 0;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    for (NSInteger value_Y = dateBeginYear; value_Y <= dateEndYear; value_Y++) {
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        
        [dateComponents setYear:value_Y];
        
        NSInteger start_M = 1;
        NSInteger end_M = 12;
        if (dateEndYear == dateBeginYear) {
            start_M = dateBeginMonth;
            end_M = dateEndMonth;
        }else if (value_Y == dateBeginYear){
            start_M = dateBeginMonth;
            end_M = 12;
        }else if (value_Y == dateEndYear){
            start_M = 1;
            end_M = dateEndMonth;
        }
        
        for (NSInteger value_M = start_M; value_M <= end_M; value_M++) {
            [dateComponents setMonth:value_M];
            [dateComponents setDay:1];
            
            NSDate *tmpMonthFirstDay = [calendar dateFromComponents:dateComponents];
            
            NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:tmpMonthFirstDay];
            
            NSInteger start_D = 1;
            NSInteger end_D = range.length;//range.length该月天数
            if (dateEndMonth == dateBeginMonth) {
                start_D = dateBeginDay;
                end_D = dateEndDay;
            }else if (value_M == dateBeginMonth){
                start_D = dateBeginDay;
                end_D = range.length;
            }else if (value_M == dateEndMonth){
                start_D = 1;
                end_D = dateEndDay;
            }
            
            for (NSUInteger value_D = start_D; value_D <= end_D; value_D++ ) {
                BOOL isFirstDayInMonth = value_D == 1;
                BOOL isMiddleDayInMonth = value_D == (range.length - 0)/2;
                BOOL isFirstMonth = value_M == 1;
                
                CJDateModel *myDate = [[CJDateModel alloc] init];
                myDate.index = dayIndex;
                myDate.year = value_Y;
                myDate.month = value_M;
                myDate.day = value_D;
                myDate.firstDayInMonth = isFirstDayInMonth;
                myDate.firstMonthInYear = isFirstMonth;
                myDate.middleDayInMonth = isMiddleDayInMonth;
                
                // 生成日期
                NSString *dateString = [NSString stringWithFormat:@"%04zd-%02zd-%02zd", value_Y, value_M, value_D];
                NSDate *date = [dateFormatter dateFromString:dateString];
                myDate.dateString = dateString;
                myDate.date = date;
                
                // 获取周几
                NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:date];
                NSInteger weekday = [dateComponents weekday];
                NSArray *weekdayStringArray = @[@"天", @"一", @"二", @"三", @"四", @"五", @"六"];
                NSString *weekdayString = [weekdayStringArray objectAtIndex:weekday-1];//注意：获取到的weekday值是从1到7
                myDate.weekday = weekday;
                myDate.weekdayString = weekdayString;
                
                [dateArray addObject:myDate];
                
                dayIndex += 1;
            }
        }
    }
    NSLog(@"最终加上占位的天数后总共有%zd天", dayIndex);
    
    return dateArray;
}


@end
