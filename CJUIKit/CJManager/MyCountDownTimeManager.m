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
@property (nonatomic, assign) NSInteger periodDuration; /**< 周期时长 */
@property (nonatomic, assign) NSInteger currentSecond;  /**< 当前显示的时间数值 */

@property (nonatomic, copy) NSInteger (^timeZeroBlock)(void);
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

/* 完整的描述请参见文件头部 */
- (void)createCountDownWithPeriodDuration:(NSTimeInterval)periodDuration
                           timeZeroBlock:(NSInteger (^)(void))timeZeroBlock
                         timeNoZeroBlock:(void (^)(NSInteger currentSecond))timeNoZeroBlock
{
    [self invalidateCountDownWithCompleteBlock:nil]; //防止没取消的时候，一直调用begin,导致开辟很多timer
    
    self.timeZeroBlock = timeZeroBlock;
    self.timeNoZeroBlock = timeNoZeroBlock;
    
    self.periodDuration = periodDuration;
    self.currentSecond = periodDuration;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    
}

/* 完整的描述请参见文件头部 */
- (void)beginCountDown {
    [_timer fire];
}



- (void)timerEvent
{
    NSInteger currentSecond = --self.currentSecond;
    [self updateCurrentSecond:currentSecond];
}

/* 完整的描述请参见文件头部 */
- (void)updateCurrentSecond:(NSInteger)currentSecond {
    self.currentSecond = currentSecond;
    
    if(self.currentSecond == 0) { //变为0一个周期结束
        if(self.timeZeroBlock) {
            self.currentSecond = self.timeZeroBlock();
        }
    } else {
        if(self.timeNoZeroBlock) {
            self.timeNoZeroBlock(self.currentSecond);
        }
    }
}

/* 完整的描述请参见文件头部 */
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
