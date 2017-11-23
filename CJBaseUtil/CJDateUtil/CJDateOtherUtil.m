//
//  CJDateOtherUtil.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/8/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDateOtherUtil.h"

@implementation CJDateOtherUtil

#pragma mark - 传入秒得到时分秒算法
///传入 秒  得到 xx:xx:xx
+ (NSString *)getHHmmssFromTimeInterval:(NSInteger)timeInterval {
    NSString *str_hour = [NSString stringWithFormat:@"%02zd",timeInterval/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02zd",(timeInterval%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02zd",timeInterval%60];
    
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
    
}

///传入 秒  得到  xx分钟xx秒
+ (NSString *)getmmssFromTimeInterval:(NSInteger)timeInterval {
    NSString *str_minute = [NSString stringWithFormat:@"%zd",timeInterval/60];
    NSString *str_second = [NSString stringWithFormat:@"%zd",timeInterval%60];
    
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
    
}


#pragma mark - Judge
/* 完整的描述请参见文件头部 */
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year];
}


///将NSDate类型的时间转换为时间戳,从1970/1/1开始
+ (long long)millisecondsFromDate:(NSDate *)date
{
    NSTimeInterval interval = [date timeIntervalSince1970];
    //NSLog(@"转换的时间戳=%f",interval);
    long long totalMilliseconds = interval*1000;
    //NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}

@end
