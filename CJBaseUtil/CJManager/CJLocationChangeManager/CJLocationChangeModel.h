//
//  CJLocationChangeModel.h
//  CJTotalDemo
//
//  Created by ciyouzen on 2018/1/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

///距离新增的模型
@interface CJLocationChangeModel : NSObject

@property (nonatomic, assign) double addedMilesFromBMK;     /**< 这段时间内新增的距离(百度计算) */
@property (nonatomic, assign) double addedMilesFromSystem;  /**< 这段时间内新增的距离(系统计算) */
@property (nonatomic, assign) NSInteger secondInterval;     /**< 这段时间内间隔的时长 */
@property (nonatomic, assign) double KMHSpeed;              /**< 这段时间内的时速(时速计算采用百度计算出来的距离) */

@end
