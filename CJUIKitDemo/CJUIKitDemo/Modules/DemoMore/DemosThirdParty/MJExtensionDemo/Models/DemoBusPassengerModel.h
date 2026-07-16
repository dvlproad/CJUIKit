//
//  DemoBusPassengerModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoBusPassengerModel : NSObject

@property (nonatomic, copy) NSString *passenger_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *id_cart;

@property (nonatomic, copy) NSString *secretIdCart;
@property (nonatomic, copy) NSString *secretPhone;

- (NSString *)secretString:(NSString *)string range:(NSRange)range;

@end
