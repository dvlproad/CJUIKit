//
//  NSDate+CJExtendedDate.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/14.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import "NSDate+CJExtendedDate.h"

@implementation NSDate (CJExtendedDate)

- (NSDate *)cj_yesterday {
    return [NSDate cj_dateWithUnitInterval:-1 calculateUnit:NSCalendarUnitDay sinceDate:self];
}

- (NSDate *)cj_tomorrow {
    return [NSDate cj_dateWithUnitInterval:1 calculateUnit:NSCalendarUnitDay sinceDate:self];
}

/** 完整的描述请参见文件头部 */
+ (NSDate *)cj_dateWithUnitInterval:(NSInteger )unitInterval calculateUnit:(NSCalendarUnit)calculateUnit sinceDate:(NSDate *)sinceDate {
    //日期转换 年月日
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
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




@end
