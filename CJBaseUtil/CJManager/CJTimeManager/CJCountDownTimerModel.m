//
//  CJCountDownTimerModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/09/06.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJCountDownTimerModel.h"

@interface CJCountDownTimerModel ()

@end



@implementation CJCountDownTimerModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxRepeatCount = 1;
    }
    return self;
}

///**
// *  初始化
// *
// *  @param maxRepeatCount 最多循环的次数(默认1)，超过最大次数时候，该model将不再执行
// *  @param minResetSecond 要累积达到至少多少秒才能执行秒数的重置操纵
// *  @param resetSecondBlock 累积达到秒数的重置操纵条件时，执行的方法
// *  @param addingSecondBlock 累积达到秒数的重置操纵条件时，即秒数在增加时候，执行的方法
// */
//- (instancetype)initWithMaxRepeatCount:(NSInteger)maxRepeatCount
//                        minResetSecond:(NSInteger)minResetSecond
//                      resetSecondBlock:(void (^)(CJCountDownTimerModel *timer))resetSecondBlock
//                     addingSecondBlock:(void (^)(CJCountDownTimerModel *timer))addingSecondBlock
//{
//    self = [super init];
//    if (self) {
//        self.maxRepeatCount = maxRepeatCount;
//        self.minResetSecond = minResetSecond;
//        self.resetSecondBlock = resetSecondBlock;
//        self.addingSecondBlock = addingSecondBlock;
//    }
//    return self;
//}

@end
