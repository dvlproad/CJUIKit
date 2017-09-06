//
//  MyCountDownTimeManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/09/06.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "MyCountDownTimeManager.h"

@interface MyCountDownTimeManager() {
    
}
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger periodDuration; /**< 周期时长 */
@property (nonatomic, assign) NSInteger currentSecond;  /**< 当前显示的时间数值 */

@property (nonatomic, copy) NSInteger (^timeZeroBlock)(NSTimer *timer);
@property (nonatomic, copy) void (^timeNoZeroBlock)(NSInteger currentSecond);

@end

@implementation MyCountDownTimeManager

+ (MyCountDownTimeManager *)sharedInstance {
    static MyCountDownTimeManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)beginCountDownWithPeriodDuration:(NSTimeInterval)periodDuration
                           timeZeroBlock:(NSInteger (^)(NSTimer *timer))timeZeroBlock
                         timeNoZeroBlock:(void (^)(NSInteger currentSecond))timeNoZeroBlock
{
    [self invalidateCountDownWithCompleteBlock:nil]; //防止没取消的时候，一直调用begin,导致开辟很多timer
    
    self.timeZeroBlock = timeZeroBlock;
    self.timeNoZeroBlock = timeNoZeroBlock;
    
    self.periodDuration = periodDuration;
    self.currentSecond = periodDuration;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerEvent:) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)timerEvent:(NSTimer *)timer
{
    self.currentSecond--;
    
    if(self.currentSecond == 0) { //变为0一个周期结束
        if(self.timeZeroBlock) {
            self.currentSecond = self.timeZeroBlock(timer);
        }
    } else {
        if(self.timeNoZeroBlock) {
            self.timeNoZeroBlock(self.currentSecond);
        }
    }
}

- (void)invalidateCountDownWithCompleteBlock:(void(^)())completeBlock
{
    if(!_timer) {
        return;
    }
    
    self.currentSecond = 0;
    [self.timer invalidate];
    self.timer = nil;
    
    if(completeBlock) {
        completeBlock();
    }
}

@end
