//
//  DemoBusStationModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoBusStationModel.h"

@implementation DemoBusStationModel

- (CLLocation *)cllocation
{
    id coordinates = self.location.coordinates;
    if (!coordinates || ![coordinates isKindOfClass:NSArray.class]) return nil;
    NSArray *coordinateArray = coordinates;
    if (coordinateArray.count != 2) return nil;
    CLLocationDegrees longitude = [coordinateArray[0] doubleValue];
    CLLocationDegrees latitude = [coordinateArray[1] doubleValue];
    return [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
}

@end
