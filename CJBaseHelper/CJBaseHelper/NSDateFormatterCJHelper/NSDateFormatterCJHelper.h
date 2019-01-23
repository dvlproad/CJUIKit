//
//  NSDateFormatterCJHelper.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/9/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  为什么要优化NSDateFormatter？首先，过度的创建NSDateFormatter用于NSDate与NSString之间转换，会导致App卡顿，打开Profile工具查一下性能，你会发现这种操作占CPU比例是非常高的。据官方说法，创建NSDateFormatter代价是比较高的，如果你使用的非常频繁，那么建议你缓存起来，缓存NSDateFormatter一定能提高效率。[性能优化之NSDateFormatter](http://www.cocoachina.com/ios/20161130/18233.html)

#import <Foundation/Foundation.h>

@interface NSDateFormatterCJHelper : NSObject {
    
}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;


+ (NSDateFormatterCJHelper *)sharedInstance;

#pragma mark - stringFromDate
///yyyy-MM-dd HH:mm:ss.SSS
- (NSString *)yyyyMMddHHmmssSSS_stringFromDate:(NSDate *)date;

///yyyy-MM-dd HH:mm:ss
- (NSString *)yyyyMMddHHmmss_stringFromDate:(NSDate *)date;

///yyyy-MM-dd HH:mm
- (NSString *)yyyyMMddHHmm_stringFromDate:(NSDate *)date;

///yyyy-MM-dd
- (NSString *)yyyyMMdd_stringFromDate:(NSDate *)date;

///yyyy-MM
- (NSString *)yyyyMM_stringFromDate:(NSDate *)date;
///yyyy年MM月
- (NSString *)yyyyMM_CN_stringFromDate:(NSDate *)date;

///MM-dd
- (NSString *)MMdd_stringFromDate:(NSDate *)date;
///MM月dd日
- (NSString *)MMdd_CN_stringFromDate:(NSDate *)date;

///HH:mm
- (NSString *)HHmm_stringFromDate:(NSDate *)date;



#pragma mark - dateFromString
///dateString 格式必须为 yyyy-MM-dd HH:mm:ss
- (NSDate *)yyyyMMddHHmmss_dateFromString:(NSString *)dateString;

///dateString 格式必须为 yyyy-MM-dd HH:mm
- (NSDate *)yyyyMMddHHmm_dateFromString:(NSString *)dateString;

///dateString 格式必须为 yyyy-MM-dd
- (NSDate *)yyyyMMdd_dateFromString:(NSString *)dateString;

///dateString 格式必须为 yyyy-MM
- (NSDate *)yyyyMM_dateFromString:(NSString *)dateString;
///dateString 格式必须为 yyyy年MM月
- (NSDate *)yyyyMM_CN_dateFromString:(NSString *)dateString;

///dateString 格式必须为 MM-dd
- (NSDate *)MMdd_dateFromString:(NSString *)dateString;
///dateString 格式必须为 MM月dd日
- (NSDate *)MMdd_CN_dateFromString:(NSString *)dateString;

///dateString 格式必须为 HH:mm
- (NSDate *)HHmm_dateFromString:(NSString *)dateString;

@end
