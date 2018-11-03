//
//  DemoBusStationModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import <CoreLocation/CoreLocation.h>

#import "DemoBusStationLocationModel.h"

/**
 *  站点信息
 */
@interface DemoBusStationModel : NSObject

@property (nonatomic, copy) NSString *flights_dispatched_time;  /**< 站点出发时间 */

@property (nonatomic, copy) NSString *station_id;               /**< 站点ID */
@property (nonatomic, copy) NSString *station_name;             /**< 站点名字 */
@property (nonatomic, copy) NSString *station_stay_time;        /**< 站点停留时间，秒 */

@property (nonatomic, copy) NSString *if_station_oncar;         /**< 是否可上车 */
@property (nonatomic, copy) NSString *station_duration_price;   /**< 站点差价 */
@property (nonatomic, copy) NSString *sequence;                 /**< 站点序号 */
@property (nonatomic, copy) NSString *status;                   /**< 站点状态 */
@property (nonatomic, strong) DemoBusStationLocationModel *location; /**< 站点经纬度 */

- (CLLocation *)cllocation;

@end
