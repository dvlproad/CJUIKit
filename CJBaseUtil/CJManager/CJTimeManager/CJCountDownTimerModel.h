//
//  CJCountDownTimerModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/09/06.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJCountDownTimerModel : NSObject

@property (nonatomic, copy) NSString *timerid;


@property (nonatomic, assign) NSInteger currentRepeatCount; /**< 当前已循环的次数 */
@property (nonatomic, assign) NSInteger maxRepeatCount;     /**< 最多循环的次数(默认1)，超过最大次数时候，该model将不再执行 */

@property (nonatomic, assign) NSInteger cumulativeSecond;   /**< 当前已累积的秒数 */

/**< 要累积达到至少多少秒才能执行秒数的重置操纵 */
@property (nonatomic, assign) NSInteger minResetSecond;

/**< 累积达到秒数的重置操纵条件时，执行的方法 */
@property (nonatomic, copy) void (^resetSecondBlock)(CJCountDownTimerModel *timer);

/**< 累积达到秒数的重置操纵条件时，即秒数在增加时候，执行的方法 */
@property (nonatomic, copy) void (^addingSecondBlock)(CJCountDownTimerModel *timer);

@end
