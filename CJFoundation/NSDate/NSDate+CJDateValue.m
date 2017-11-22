//
//  NSDate+CJDateValue.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 16/12/14.
//  Copyright (c) 2014年 dvlproad. All rights reserved.
//

#import "NSDate+CJDateValue.h"

@implementation NSDate (CJDateValue)

/** 完整的描述请参见文件头部 */
- (NSString *)cj_standString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [dateFormatter stringFromDate:self];
    return string;
}

/** 完整的描述请参见文件头部 */
- (NSString *)cj_weekdayString {
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:self];
    NSInteger weekday = [dateComponents weekday];
    
    NSArray *weekdayStringArray = @[@"天", @"一", @"二", @"三", @"四", @"五", @"六"];
    NSString *weekdayString = [weekdayStringArray objectAtIndex:weekday-1];//注意：获取到的weekday值是从1到7
    return weekdayString;
}


@end
