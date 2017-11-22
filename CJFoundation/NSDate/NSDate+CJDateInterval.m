//
//  NSDate+CJDateInterval.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/7/4.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NSDate+CJDateInterval.h"

@implementation NSDate (CJDateInterval)

/** 完整的描述请参见文件头部 */
+ (NSInteger)cj_dateIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate inCalculateUnit:(NSCalendarUnit)calculateUnit {
    /*方法①：计算出相差多少秒，再根据秒来计算
    NSTimeInterval timeInterval = [toDate timeIntervalSinceDate:fromDate];
     
    NSInteger count = timeInterval/60/60/24;
    */
    
    ///*方法②：
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger count = 0;
    switch (calculateUnit) {
        case NSCalendarUnitDay: {
            NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
            count = [components day];
            break;
        }
        case NSCalendarUnitMonth: {
            NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:fromDate toDate:toDate options:0];
            count = [components month];
            break;
        }
        case NSCalendarUnitYear: {
            NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:fromDate toDate:toDate options:0];
            count = [components year];
            break;
        }
        case NSCalendarUnitHour: {
            NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:fromDate toDate:toDate options:0];
            count = [components hour];
            break;
        }
        case NSCalendarUnitMinute: {
            NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:fromDate toDate:toDate options:0];
            count = [components minute];
            break;
        }
        case NSCalendarUnitSecond: {
            NSDateComponents *components = [calendar components:NSCalendarUnitSecond fromDate:fromDate toDate:toDate options:0];
            count = [components second];
            break;
        }
            
        default:
            break;
    }
    //*/
    
    return count;
}

/** 完整的描述请参见文件头部 */
+ (NSInteger)cj_ageIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    ///*方法①：
    NSInteger iAge2 = [NSDate cj_dateIntervalFromDate:fromDate toDate:toDate inCalculateUnit:NSCalendarUnitYear];
    NSLog(@"方法①计算出的年纪为%zd", iAge2);
    //*/
    
    //方法②：
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:fromDate];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:toDate];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    NSLog(@"方法②计算出的年纪为%zd", iAge);
    
    return iAge;
}


@end
