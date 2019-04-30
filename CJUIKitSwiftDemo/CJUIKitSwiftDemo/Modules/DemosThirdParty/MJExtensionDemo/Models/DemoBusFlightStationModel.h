//
//  DemoBusFlightStationModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/19.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoBusStationModel.h"
//#import "DemoBusFlightStationOnOffChangeModel.h"
#import "DemoBusFlightStationOnOffDetailModel.h"

/**
 *  班次的站点信息
 */
@interface DemoBusFlightStationModel : DemoBusStationModel

@property (nonatomic, copy) NSString *flight_id;        /**< 班次号 */
@property (nonatomic, copy) NSString *station_sequnce;

//站点的详细上下车信息
@property (nonatomic, strong) DemoBusFlightStationOnOffDetailModel *onDetailInfo;  /**< 站点上车信息 */
@property (nonatomic, strong) DemoBusFlightStationOnOffDetailModel *offDetailInfo; /**< 站点下车信息 */

//站点的简洁上下车变化信息
//@property (nonatomic, strong) DemoBusFlightStationOnOffChangeModel *onOffChangeInfo;/**< 站点上下车变化信息 */

- (void)updateOnoffInfoWithDictionary:(NSDictionary *)dictionary;

@end
