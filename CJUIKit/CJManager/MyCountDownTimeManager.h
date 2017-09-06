//
//  MyCountDownTimeManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/09/06.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  一个全局的倒计时管理器
 */
@interface MyCountDownTimeManager : NSObject
{
    
}

+ (MyCountDownTimeManager *)sharedInstance;

/**
 *  启动计时器
 *
 *  @param periodDuration   倒计时的周期
 *  @param timeZeroBlock    倒计时到0的时候执行的操作(block返回结束那个时刻，当前的秒数(如果返回0，应主动让计时器停止))
 *  @param timeNoZeroBlock  倒计时数字不为0的时候执行的操作
 */
- (void)beginCountDownWithPeriodDuration:(NSTimeInterval)periodDuration
                            timeZeroBlock:(NSInteger (^)(NSTimer *timer))timeZeroBlock
                         timeNoZeroBlock:(void (^)(NSInteger currentSecond))timeNoZeroBlock;

- (void)invalidateCountDownWithCompleteBlock:(void(^)())completeBlock;

@end
