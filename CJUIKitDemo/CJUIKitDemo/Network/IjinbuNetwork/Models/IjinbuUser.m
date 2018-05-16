//
//  IjinbuUser.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/4/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuUser.h"
#import "IjinbuSession.h"

@implementation IjinbuUser

+ (instancetype)current {
    return [IjinbuSession current].user;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imName":     @"hxAccount",
             @"imPassword": @"hxPassWord",
             @"token":      @"token",
             };
}

@end
