//
//  ServerTimeCJHelper.m
//  AppServerHelper
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ServerTimeCJHelper.h"

@implementation ServerTimeCJHelper

/// 保存服务器返回的毫秒级时间戳（请在程序执行时候，通过api请求获取服务区事件，并调用此方法保存起来）
+ (void)saveServerMillisecondTime:(NSTimeInterval)serverMillisecondTime {
    NSTimeInterval timeDiff = serverMillisecondTime - [NSProcessInfo processInfo].systemUptime * 1000;
    //NSLog(@"服务器返回的毫秒级时间戳为：%f", serverMillisecondTime);
    [self __saveTimeDiff:timeDiff];
}

/// 获取当前的毫秒时间戳（常用于用户“离线”操作某个动作的时候，在未来把这个时间戳告诉后台）
+ (NSTimeInterval)getNowServerMillisecondTime {
    NSTimeInterval timeDiff = [self __getTimeDiff];
    if (timeDiff == 0) {
        NSLog(@"警告⚠️⚠️⚠️⚠️⚠️：您未提前获取服务器时间,请先调用api请求接口请求，未防止崩溃，这里临时给予容错处理");
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSInteger iTime = (NSInteger)(time * 1000);
        return iTime;
    }
    NSTimeInterval servTime = timeDiff + [NSProcessInfo processInfo].systemUptime *1000;
    return servTime;
}


/// 获取当前的服务器时间NSDate
+ (NSDate *)getNowServerDate {
    NSTimeInterval servTime = [self getNowServerMillisecondTime];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:servTime/1000];
    return date;
}

#pragma mark - Private Method
+ (NSTimeInterval)__getTimeDiff {
    NSTimeInterval timeDiff = [[NSUserDefaults standardUserDefaults] doubleForKey:@"serverTimeDiff"];
    return timeDiff;
}

+ (void)__saveTimeDiff:(NSTimeInterval)timeDiff {
    [[NSUserDefaults standardUserDefaults] setDouble:timeDiff forKey:@"serverTimeDiff"];
}


/// 计算两个时间相差多少毫秒
+ (NSTimeInterval)millisecondIntervalFromBigDate:(NSDate *)bigDate toSmallDate:(NSDate *)smallDate {
    NSTimeInterval secondInterval = [bigDate timeIntervalSinceDate:smallDate];  // 两个时间相差多少秒
    NSTimeInterval millisecondInterval = secondInterval * 1000;                 // 两个时间相差多少毫秒
    return millisecondInterval;
}

/// 将服务器返回的毫秒时间戳转成字符串
+ (NSString *)getMMSSFromSS:(NSInteger)millisecond {
    NSInteger seconds = millisecond/1000;
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", seconds/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (seconds%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld", seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@", str_hour, str_minute, str_second];
    return format_time;
}

@end
