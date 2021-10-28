//
//  CJTimerModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/09/06.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJTimerModel : NSObject

@property (nonatomic, copy) NSString *timerid;  /**< 备用的属性：用来区分timer */


@property (nonatomic, assign) NSInteger currentRepeatCount; /**< 当前已循环的次数(默认0) */
@property (nonatomic, assign) NSInteger maxRepeatCount;     /**< 最多循环的次数(默认1)，超过最大次数时候，该model将不再执行 */

@property (nonatomic, assign) NSInteger cumulativeSecond;   /**< 当前已累积的秒数 */

/**< 要累积达到至少多少秒才能执行秒数的重置操纵(如果设置7秒，而定时器是5秒一次，则要等到10秒才会执行) */
@property (nonatomic, assign) NSInteger minResetSecond;

/**< 累积达到秒数的重置操纵条件时，执行的方法 */
@property (nonatomic, copy) void (^resetSecondBlock)(CJTimerModel *timer);

/**< 累积达到秒数的重置操纵条件时，即秒数在增加时候，执行的方法 */
@property (nonatomic, copy) void (^addingSecondBlock)(CJTimerModel *timer);

/**
 *  类方法初始化(创建一个默认只会执行一次的数据。若需要修改执行的次数，可在生成后修改)
 *
 *  @param minResetSecond 要累积达到至少多少秒才能执行秒数的重置操纵
 *  @param resetSecondBlock 累积达到秒数的重置操纵条件时，执行的方法
 *  @param addingSecondBlock 累积达到秒数的重置操纵条件时，即秒数在增加时候，执行的方法
 */
+ (instancetype)timerModelWithMinResetSecond:(NSInteger)minResetSecond
                           addingSecondBlock:(void(^)(CJTimerModel *timer))addingSecondBlock
                            resetSecondBlock:(void(^)(CJTimerModel *timer))resetSecondBlock;

@end

NS_ASSUME_NONNULL_END
