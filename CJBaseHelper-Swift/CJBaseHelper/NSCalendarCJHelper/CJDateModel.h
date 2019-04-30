//
//  CJDateModel.h
//  ChartDemo
//
//  Created by ciyouzen on 16/8/16.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

//以后可以参考 NSDateComponents 来进一步改进

@interface CJDateModel : NSObject

@property (nonatomic, assign) NSInteger index;  /**< 该天的索引 */

@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) NSString *weekdayString;
@property (nonatomic, assign) NSInteger weekday;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign, getter=isFirstDayInMonth) BOOL firstDayInMonth;  /**< 该天是否是该天所在月的第一天 */
@property (nonatomic, assign, getter=isMiddleDayInMonth) BOOL middleDayInMonth;/**< 该天是否是该天所在月的中间天 */
@property (nonatomic, assign, getter=isFirstMonthInYear) BOOL firstMonthInYear;/**< 该天所在的月是否是该天所在年的第一月 */

@end
