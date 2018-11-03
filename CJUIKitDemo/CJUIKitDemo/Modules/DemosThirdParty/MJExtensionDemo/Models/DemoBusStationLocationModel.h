//
//  DemoBusStationLocationModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <MJExtension/MJExtension.h>

/**
 *  站点经纬度信息
 */
@interface DemoBusStationLocationModel : NSObject

@property (nonatomic, copy) NSString *type;         /**< 值"Point" */

//TODO客运:
@property (nonatomic, strong) id coordinates;
//NSDictionary *locationParams = @{@"lng":@(location.coordinate.longitude),
//                                 @"lat":@(location.coordinate.latitude)};

@end
