//
//  DemoBusFlightModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoBusFlightModel.h"

@implementation DemoBusFlightModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"flight_id":  @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"station_infos":  [DemoBusFlightStationModel class],
             };
}

@end
