//
//  ServerTimeCJHelper.h
//  AppServerHelper
//
//  Created by ciyouzen on 2018/10/22.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerTimeCJHelper : NSObject

/// 保存服务器返回的毫秒级时间戳（请在程序执行时候，通过api请求获取服务区事件，并调用此方法保存起来）
+ (void)saveServerMillisecondTime:(NSTimeInterval)serverMillisecondTime;

/// 获取当前的时间戳（常用于用户“离线”操作某个动作的时候，在未来把这个时间戳告诉后台）
+ (NSTimeInterval)getNowServerMillisecondTime;

/// 获取当前的服务器时间
+ (NSDate *)getNowServerDate;

/// 计算两个时间相差多少毫秒
+ (NSTimeInterval)millisecondIntervalFromBigDate:(NSDate *)bigDate toSmallDate:(NSDate *)smallDate;

/// 将服务器返回的毫秒时间戳转成字符串
+ (NSString *)getMMSSFromSS:(NSInteger)millisecond;

@end

NS_ASSUME_NONNULL_END
