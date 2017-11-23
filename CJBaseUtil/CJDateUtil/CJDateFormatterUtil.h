//
//  CJDateFormatterUtil.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/9/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJDateFormatterUtil : NSObject {
    
}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;


+ (CJDateFormatterUtil *)sharedInstance;

#pragma mark - stringFromDate
- (NSString *)yyyyMMddHHmmssSSS_stringFromDate:(NSDate *)date;

- (NSString *)yyyyMMddHHmmss_stringFromDate:(NSDate *)date;

- (NSString *)yyyyMMddHHmm_stringFromDate:(NSDate *)date;

- (NSString *)yyyyMMdd_stringFromDate:(NSDate *)date;

- (NSString *)MMdd_stringFromDate:(NSDate *)date;

- (NSString *)HHmm_stringFromDate:(NSDate *)date;



#pragma mark - dateFromString
- (NSDate *)yyyyMMddHHmmss_dateFromString:(NSString *)dateString;

- (NSDate *)yyyyMMddHHmm_dateFromString:(NSString *)dateString;

- (NSDate *)yyyyMMdd_dateFromString:(NSString *)dateString;

@end
