//
//  MyCountDownTimeManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/09/06.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSUInteger, MyCountDownTimeZeroAction) {
//    MyCountDownTimeZeroActionInvalidate,    /**< 销毁(结束定时器) */
//    MyCountDownTimeZeroActionRestore,       /**< 还原(多用于循环定时,会自动将定时器时间还原到周期时间) */
//};


/**
 *  一个全局倒计时管理器
 */
@interface MyCountDownTimeManager : NSObject
{
    
}

+ (MyCountDownTimeManager *)sharedInstance;

@property (nonatomic, strong) NSTimer *timer;

/**
 *  创建计时器
 *
 *  @param periodDuration   倒计时的周期
 *  @param timeZeroBlock    倒计时到0的时候执行的操作(block返回结束那个时刻，当前的秒数(如果返回0，应主动让计时器停止))
 *  @param timeNoZeroBlock  倒计时数字不为0的时候执行的操作
 */
- (void)createCountDownWithPeriodDuration:(NSTimeInterval)periodDuration
                            timeZeroBlock:(NSInteger (^)(void))timeZeroBlock
                          timeNoZeroBlock:(void (^)(NSInteger currentSecond))timeNoZeroBlock;

/**
 *  启动计时器
 */
- (void)beginCountDown;

/**
 *  更新当前定时器定位到的时间
 */
- (void)updateCurrentSecond:(NSInteger)currentSecond;

/**
 *  销毁/结束定时器（下次使用，需重新create）
 */
- (void)invalidateCountDownWithCompleteBlock:(void(^)())completeBlock;

@end
