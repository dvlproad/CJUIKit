//
//  DemoBusFlightStationOnOffDetailModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

/**
 *  某个站点详细的上下车信息
 */
#import <Foundation/Foundation.h>
#import "DemoBusPassengerOrderModel.h"

@interface DemoBusFlightStationOnOffDetailModel : NSObject

@property (nonatomic, assign) NSInteger changePeopleCount;  /**< 变化人数 */
@property (nonatomic, strong) NSArray<DemoBusPassengerOrderModel *> *passengerList; /**< 乘客列表 */

@end
