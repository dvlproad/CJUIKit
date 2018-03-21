//
//  CJLocationChangeManager.m
//  CJTotalDemo
//
//  Created by ciyouzen on 2018/1/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJLocationChangeManager.h"

#ifdef CJTESTPOD
#import "CJCalendarUtil.h"
#else
#import <CJBaseUtil/CJCalendarUtil.h>
#endif

@interface CJLocationChangeManager () {
    
}
@property (nonatomic, strong) NSTimer *calculateTimer;     /**< 统计或者计算路程/时长的计时器 */

@end



@implementation CJLocationChangeManager


+ (CJLocationChangeManager *)sharedInstance {
    static CJLocationChangeManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

///开启计时器
- (void)startCalculateTimer {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.calculateTimer == nil) {
            self.calculateTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(calculateAction) userInfo:nil repeats:YES];
        }
        [self.calculateTimer setFireDate:[NSDate date]];
    });
}

- (void)calculateAction {
    //第一次的时候计算使用上车的时间和位置，之后使用每次更新后的时间和位置
    /* ①、获取新旧两点点 */
    NSAssert(self.getCurrentLocationHandle, @"请先设置获取当前位置的方法");
    
    CLLocation *currentLocation = self.getCurrentLocationHandle();
    if (self.lastCalcucateLocation == nil) {
        self.lastCalcucateLocation = currentLocation;
        return;
    }
    CLLocation *oldLocation = self.lastCalcucateLocation;
    if ([currentLocation.timestamp compare:oldLocation.timestamp] != NSOrderedDescending) {
//        NSLog(@"oldDate = %@", [NSString stringWithFormat:@"%@,", oldLocation.timestamp]);
//        NSLog(@"currentDate = %@", [NSString stringWithFormat:@"%@,", currentLocation.timestamp]);
//        CJAppLog(CJAppLogTypeINFO, @"distanceCalculate", @"从时间上看出所取当前点并不是实际当前点，请检查(原因一般为用户位置更新频率设为太多米，而导致未更新)");
        return;
    }
    
    /* ②、计算两次计算的距离时间等 */
    CJLocationChangeModel *locationChangeModel = [self calculateAddedModelFromOldLocation:oldLocation toNewLocation:currentLocation];
    if (self.updateBlock) {
        self.updateBlock(locationChangeModel);
    }
    
    self.lastCalcucateLocation = currentLocation;
    //self.lastCalcucateDate = [NSDate date];
}


///计算乘客上车后的行驶的总路程即该路程中的小于12km/h的时间（单位秒）

- (CJLocationChangeModel *)calculateAddedModelFromOldLocation:(CLLocation *)oldLocation toNewLocation:(CLLocation *)newLocation {
    /* 计算从A点到B点增加的距离 */
    NSAssert(self.calculateDistanceHandle, @"请先设置计算两点距离的方法");
    
    CLLocationDistance addedMilesFromBMK = self.calculateDistanceHandle(oldLocation, newLocation);
    CLLocationDistance addedMilesFromSystem = [newLocation distanceFromLocation:oldLocation];
    
    if (addedMilesFromBMK > 1000*1000) { //大于1000公里（为临时解决乘车中，彻底关掉app后，再启动进来突然竖直增加太大的问题）
        return nil;
    }
    
    
    /* 计算从A点到B点增加的时长 */
    NSDate *lastCalcucateDate = oldLocation.timestamp;
    NSDate *currentCalcucateDate = newLocation.timestamp;
    NSInteger secondInterval = [CJCalendarUtil unitIntervalFromDate:lastCalcucateDate toDate:currentCalcucateDate inCalculateUnit:NSCalendarUnitSecond];
    
    
    /* 计算从A点到B点时速是否小于指定值 */
    CGFloat currentKmhSpeed = (addedMilesFromBMK / secondInterval) * 3.6; //时速m/s到km/h的转换
    
    CJLocationChangeModel *locationChangeModel = [[CJLocationChangeModel alloc] init];
    locationChangeModel.addedMilesFromBMK = addedMilesFromBMK;
    locationChangeModel.addedMilesFromSystem = addedMilesFromSystem;
    locationChangeModel.secondInterval = secondInterval;
    locationChangeModel.KMHSpeed = currentKmhSpeed;
    
    return locationChangeModel;
}


@end
