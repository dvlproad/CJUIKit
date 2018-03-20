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
 *  一个全局倒计时管理器(全局定时器的时候才用，其他的自己创建定时器就好了)
 *  eg:(因为计时器有可能属于ViewController，但也有可能属于一个全局的，比如全局监控一个数组，如果数组未空，则启动计时器，直到数组为空，才取消计时器，下次数组有值加入，又变成未空时候，再启动计时器)
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
 *  @param periodRepeat     倒计时一周期结束后是否重复或继续
 *  @param timeZeroBlock    倒计时到0的时候执行的操作(block返回结束那个时刻，本周期剩余的时间(如果返回0，应主动让计时器停止))
 *  @param timeNoZeroBlock  倒计时数字不为0的时候执行的操作(remainSecond:本周期剩余的时间)
 */
- (void)createCountDownWithPeriodDuration:(NSTimeInterval)periodDuration
                             periodRepeat:(BOOL)periodRepeat
                            timeZeroBlock:(NSInteger (^)(void))timeZeroBlock
                          timeNoZeroBlock:(void (^)(NSInteger remainSecond))timeNoZeroBlock;

/**
 *  启动计时器
 */
- (void)beginCountDown;

/**
 *  更新倒计时定时器剩余的时间
 */
- (void)updateRemainSecond:(NSInteger)remainSecond;

/**
 *  销毁/结束定时器（下次使用，需重新create）
 */
- (void)invalidateCountDownWithCompleteBlock:(void(^)(void))completeBlock;

@end
