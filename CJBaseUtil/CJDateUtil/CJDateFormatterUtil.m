//
//  CJDateFormatterUtil.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/9/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDateFormatterUtil.h"

@implementation CJDateFormatterUtil

/**
 *  创建单例
 *
 *  @return 单例
 */
+ (CJDateFormatterUtil *)sharedInstance {
    static CJDateFormatterUtil *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - lazyload
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}


#pragma mark - stringFromDate
- (NSString *)yyyyMMddHHmmssSSS_stringFromDate:(NSDate *)date {
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *)yyyyMMddHHmmss_stringFromDate:(NSDate *)date {
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *)yyyyMMddHHmm_stringFromDate:(NSDate *)date {
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *)yyyyMMdd_stringFromDate:(NSDate *)date {
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *)MMdd_stringFromDate:(NSDate *)date {
    [self.dateFormatter setDateFormat:@"MM月dd日"];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *)HHmm_stringFromDate:(NSDate *)date {
    [self.dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    return dateString;
}


#pragma mark - dateFromString
- (NSDate *)yyyyMMddHHmmss_dateFromString:(NSString *)dateString {
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [self.dateFormatter dateFromString:dateString];
    return date;
}

- (NSDate *)yyyyMMddHHmm_dateFromString:(NSString *)dateString {
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [self.dateFormatter dateFromString:dateString];
    return date;
}

- (NSDate *)yyyyMMdd_dateFromString:(NSString *)dateString {
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [self.dateFormatter dateFromString:dateString];
    return date;
}


@end
