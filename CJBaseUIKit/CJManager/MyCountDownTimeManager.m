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
@property (nonatomic, assign) BOOL periodRepeat;        /**< 倒计时一周期结束后是否重复或继续 */
@property (nonatomic, assign) NSInteger remainSecond;  /**< 当前显示的时间数值(本周期剩余的时间) */

@property (nonatomic, copy) NSInteger (^timeZeroBlock)(void);
@property (nonatomic, copy) void (^timeNoZeroBlock)(NSInteger remainSecond);

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
                             periodRepeat:(BOOL)periodRepeat
                           timeZeroBlock:(NSInteger (^)(void))timeZeroBlock
                         timeNoZeroBlock:(void (^)(NSInteger remainSecond))timeNoZeroBlock
{
    [self invalidateCountDownWithCompleteBlock:nil]; //防止没取消的时候，一直调用begin,导致开辟很多timer
    
    self.timeZeroBlock = timeZeroBlock;
    self.timeNoZeroBlock = timeNoZeroBlock;
    
    self.periodDuration = periodDuration;
    self.periodRepeat = periodRepeat;
    self.remainSecond = periodDuration;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    
}

/* 完整的描述请参见文件头部 */
- (void)beginCountDown {
    [_timer fire];
}



- (void)timerEvent
{
    NSInteger remainSecond = --self.remainSecond;
    [self updateRemainSecond:remainSecond];
}

/* 完整的描述请参见文件头部 */
- (void)updateRemainSecond:(NSInteger)remainSecond {
    self.remainSecond = remainSecond;
    
    if(self.remainSecond == 0) { //变为0一个周期结束
        if(self.timeZeroBlock) {
            self.remainSecond = self.timeZeroBlock();
        }
        
        if (!self.periodRepeat) {
            [self.timer invalidate];
            self.timer = nil;
        }
        
    } else {
        if(self.timeNoZeroBlock) {
            self.timeNoZeroBlock(self.remainSecond);
        }
    }
}

/* 完整的描述请参见文件头部 */
- (void)invalidateCountDownWithCompleteBlock:(void(^)(void))completeBlock
{
    if(!_timer) {
        return;
    }
    
    self.remainSecond = 0;
    [self.timer invalidate];
    self.timer = nil;
    
    if(completeBlock) {
        completeBlock();
    }
}


@end
