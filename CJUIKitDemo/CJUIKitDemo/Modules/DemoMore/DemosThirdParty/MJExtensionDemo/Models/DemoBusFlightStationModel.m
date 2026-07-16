//
//  DemoBusFlightStationModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/19.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoBusFlightStationModel.h"

@implementation DemoBusFlightStationModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"flight_id":          @"id",
             @"station_sequnce":    @"sequence",
             
             };
}

- (void)updateOnoffInfoWithDictionary:(NSDictionary *)dictionary
{
    NSDictionary *passengerList = [dictionary objectForKey:@"list"];
    NSArray<DemoBusPassengerOrderModel *> *passengeModels = [DemoBusPassengerOrderModel mj_objectArrayWithKeyValuesArray:passengerList];
    
    //上车人数
    NSPredicate *startPredicate = [NSPredicate predicateWithFormat:@"start_station_id == %@", self.station_id];
    NSArray *onPassengers = [passengeModels filteredArrayUsingPredicate:startPredicate];
    _onDetailInfo.passengerList = onPassengers;
    _onDetailInfo.changePeopleCount = onPassengers.count;
    
    //下车人数
    NSPredicate *endPredicate = [NSPredicate predicateWithFormat:@"end_station_id == %@", self.station_id];
    NSArray *offPassengers = [passengeModels filteredArrayUsingPredicate:endPredicate];
    _offDetailInfo.passengerList = offPassengers;
    _offDetailInfo.changePeopleCount = offPassengers.count;
}

@end
