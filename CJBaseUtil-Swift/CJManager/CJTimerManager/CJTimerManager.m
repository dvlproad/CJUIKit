//
//  CJTimerManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/09/06.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTimerManager.h"

@interface CJTimerManager() {
    
}
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval timeInterval;

@end

@implementation CJTimerManager

+ (CJTimerManager *)sharedInstance {
    static CJTimerManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

/* 完整的描述请参见文件头部 */
- (void)createTimerWithTimeInterval:(NSTimeInterval)timeInterval
{
    [self invalidateTimerWithCompleteBlock:nil]; //防止没取消的时候，一直调用begin,导致开辟很多timer
    
    self.timeInterval = timeInterval;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    _timer = timer;
}

/* 完整的描述请参见文件头部 */
- (BOOL)isTimerValid {
    return [_timer isValid];
}

/* 完整的描述请参见文件头部 */
- (void)fireTimer {
    [_timer fire];
}

- (void)timerEvent {
    NSArray<CJTimerModel *> *timerModels = self.timerModels;
    for (CJTimerModel *timerModel in timerModels) {
        if (timerModel.currentRepeatCount >= timerModel.maxRepeatCount) {
            continue;
        }
        
        timerModel.cumulativeSecond += self.timeInterval;
        
        if (timerModel.cumulativeSecond >= timerModel.minResetSecond) {
            if(timerModel.resetSecondBlock) {
                timerModel.resetSecondBlock(timerModel);
            }
            timerModel.cumulativeSecond = 0;
            
            timerModel.currentRepeatCount++;
            
        } else {
            if (timerModel.addingSecondBlock) {
                timerModel.addingSecondBlock(timerModel);
            }
        }
    }
}

/* 完整的描述请参见文件头部 */
- (void)invalidateTimerWithCompleteBlock:(void(^)(void))completeBlock
{
    if(!_timer) {
        return;
    }
    
    [self.timer invalidate];
    self.timer = nil;
    
    if(completeBlock) {
        completeBlock();
    }
}


@end
