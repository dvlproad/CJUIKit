//
//  CJTimerModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/09/06.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJTimerModel.h"

@interface CJTimerModel ()

@end



@implementation CJTimerModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxRepeatCount = 1;
    }
    return self;
}

/* 完整的描述请参见文件头部 */
+ (instancetype)timerModelWithMinResetSecond:(NSInteger)minResetSecond
                           addingSecondBlock:(void(^)(CJTimerModel *timer))addingSecondBlock
                            resetSecondBlock:(void(^)(CJTimerModel *timer))resetSecondBlock
{
    CJTimerModel *timerModel = [[CJTimerModel alloc] init];
    timerModel.minResetSecond = minResetSecond;
    timerModel.addingSecondBlock = addingSecondBlock;
    timerModel.resetSecondBlock = resetSecondBlock;
    timerModel.maxRepeatCount = 1;
    timerModel.currentRepeatCount = 0;
    
    return timerModel;
}

@end
