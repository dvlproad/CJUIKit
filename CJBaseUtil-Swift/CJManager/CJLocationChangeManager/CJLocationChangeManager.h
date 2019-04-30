//
//  CJLocationChangeManager.h
//  CJTotalDemo
//
//  Created by ciyouzen on 2018/1/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "CJLocationChangeModel.h"

@interface CJLocationChangeManager : NSObject {
    
}
//使用前，请先设置以下两个值
@property (nonatomic, copy) CLLocation * (^getCurrentLocationHandle)(void);/**< 获得当前位置的方法 */
@property (nonatomic, copy) CLLocationDistance (^calculateDistanceHandle)(CLLocation *oldLocation, CLLocation *newLocation);/**< 计算两点之间距离的方法 */


//@property (nonatomic, strong) NSDate *lastCalcucateDate;        /**< 上一次计算距离的日期 */
@property (nonatomic, strong) CLLocation *lastCalcucateLocation;/**< 上一次计算距离的位置 */

@property (nonatomic, copy) void (^updateBlock)(CJLocationChangeModel *locationChangeModel);/**< 行驶时长、距离更新了的block */


+ (CJLocationChangeManager *)sharedInstance;

///开启计时器
- (void)startCalculateTimer;

@end
