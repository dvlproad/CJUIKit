//
//  DemoBusPassengerModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/17.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoBusPassengerModel.h"

@implementation DemoBusPassengerModel

- (NSString *)secretString:(NSString *)string range:(NSRange)range
{
    NSMutableString *starString = [NSMutableString string];
    for (int i = 0; i < range.length; i++) {
        [starString appendString:@"*"];
    }
    return [string stringByReplacingCharactersInRange:range withString:starString];
}

- (NSString *)secretIdCart
{
    if (_secretIdCart) return _secretIdCart;
    if (!_id_cart)
    {
        _id_cart = @"";
        return _id_cart;
    }
    
    if (_id_cart.length <= 8) return _id_cart;
    NSRange range = NSMakeRange(4, _id_cart.length - 8);
    _secretIdCart = [self secretString:_id_cart range:range];
    
    return _secretIdCart;
}

- (NSString *)secretPhone
{
    if (_secretPhone) return _secretPhone;
    if (!_phone)
    {
        _secretPhone = @"";
        return _secretPhone;
    }
    
    if (_phone.length <= 6) return _phone;
    NSRange range = NSMakeRange(3, _phone.length - 6);
    _secretPhone = [self secretString:_phone range:range];
    
    return _secretPhone;
}

@end
