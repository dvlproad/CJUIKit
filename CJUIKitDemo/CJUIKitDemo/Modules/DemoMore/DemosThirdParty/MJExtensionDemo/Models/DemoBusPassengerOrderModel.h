//
//  DemoBusPassengerOrderModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoBusPassengerModel.h"
#import "DemoBusStationModel.h"

@interface DemoBusPassengerOrderModel : DemoBusPassengerModel

@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *flights_no;
@property (nonatomic, copy) NSString *driver_id;
@property (nonatomic, copy) NSString *appoint_time;//出发时间
@property (nonatomic, copy) NSString *start_station_id;
@property (nonatomic, copy) NSString *end_station_id;

/**0(app),1(客服)，2(微信)，3(司机端)，98(顺风车)，99(爱心直通车)，200(扫码下单),300（小程序）,400（小程序扫码下单）*/
@property (nonatomic, copy) NSString *order_origin;

/** 乘车订单状态（车票的状态） 2:待检票 4:已检票 10：检票下车 100：订单完成 20,23 乘客，客服取消 25:已过期*/
@property (nonatomic, copy) NSString *order_status;

@property (nonatomic, strong) NSString *start_station;
@property (nonatomic, strong) NSString *end_station;
@property (nonatomic, strong) NSString *start_station_name;
@property (nonatomic, strong) NSString *end_station_name;
@property (nonatomic, strong) NSString *order_price; //订单价格
@property (nonatomic, strong) NSString *order_count;//乘客人数
@property (nonatomic, strong) NSString *order_time;//下单时间

@property (nonatomic, strong) NSString *order_status_string;

@end
