//
//  CJDateFormatterUtil.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/9/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  为什么要优化NSDateFormatter？首先，过度的创建NSDateFormatter用于NSDate与NSString之间转换，会导致App卡顿，打开Profile工具查一下性能，你会发现这种操作占CPU比例是非常高的。据官方说法，创建NSDateFormatter代价是比较高的，如果你使用的非常频繁，那么建议你缓存起来，缓存NSDateFormatter一定能提高效率。[性能优化之NSDateFormatter](http://www.cocoachina.com/ios/20161130/18233.html)

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
