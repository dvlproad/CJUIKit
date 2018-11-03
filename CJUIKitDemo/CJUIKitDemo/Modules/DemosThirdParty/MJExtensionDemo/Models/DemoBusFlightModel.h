//
//  DemoBusFlightModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

#import "DemoBusFlightStationModel.h"

/**
 *  班次信息
 */
@interface DemoBusFlightModel : NSObject

@property (nonatomic, copy) NSString *line_id;          /**< 线路ID */
@property (nonatomic, copy) NSString *flight_id;        /**< 班次ID */
@property (nonatomic, copy) NSString *flights_no;        /**< 班次号 */
@property (nonatomic, copy) NSString *flights_date;     /**< 班次日期 */
@property (nonatomic, copy) NSArray<DemoBusFlightStationModel *> *station_infos; /**< 该班次的所有站点信息 */

@property (nonatomic, copy) NSString *line_base_price;  /**< 线路基本价 */
@property (nonatomic, copy) NSString *available_seats;  /**< 班次可用座位数 */
@property (nonatomic, copy) NSString *status;           /**< 班次状态 */

@end
