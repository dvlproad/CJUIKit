//
//  CJDateModelUtil.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 15/4/9.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "CJDateModelUtil.h"

@implementation CJDateModelUtil

/** 完整的描述请参见文件头部 */
- (NSMutableArray<CJDateModel *> *)findAllCJDateModelFromDate:(NSDate *)dateBegin toDate:(NSDate *)toDate {
    NSDate *dateEnd = toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *dateComponentsBegin = [calendar components:calendarUnit fromDate:dateBegin];
    
    NSInteger dateBeginYear  = [dateComponentsBegin year];
    NSInteger dateBeginMonth = [dateComponentsBegin month];
    NSInteger dateBeginDay = [dateComponentsBegin day];
    
    NSDateComponents *dateComponentsEnd = [calendar components:calendarUnit fromDate:dateEnd];
    
    NSInteger dateEndYear  = [dateComponentsEnd year];
    NSInteger dateEndMonth = [dateComponentsEnd month];
    NSInteger dateEndDay = [dateComponentsEnd day];
    
    NSMutableArray *dateArray = [[NSMutableArray alloc]init];
    NSUInteger dayIndex = 0;
    
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
                BOOL isFirstDay = value_D == 1;
                BOOL isMiddleDayInMonth = value_D == (range.length - 0)/2;
                BOOL isFirstMonth = value_M == 1;
                
                CJDateModel *myDate = [[CJDateModel alloc] init];
                myDate.index = dayIndex;
                myDate.year = value_Y;
                myDate.month = value_M;
                myDate.day = value_D;
                myDate.firstDayInMonth = isFirstDay;
                myDate.firstMonthInYear = isFirstMonth;
                myDate.middleDayInMonth = isMiddleDayInMonth;
                
                [dateArray addObject:myDate];
                
                dayIndex += 1;
            }
        }
    }
    NSLog(@"最终加上占位的天数后总共有%zd天", dayIndex);
    
    return dateArray;
}

@end
