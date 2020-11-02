//
//  CJCacheDataModel.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJCacheDataModel.h"

@implementation CJCacheDataModel

- (instancetype)initWithDataObject:(id<NSCoding>)object {
    return [self initWithDataObject:object timeInterval:-1];
}

- (instancetype)initWithDataObject:(id<NSCoding>)object timeInterval:(NSTimeInterval)timeInterval {
    self = [super init];
    if (self) {
        _dataObject = object;
        _beginDate = [NSDate date];
        if (timeInterval >= 0) {
            _needCache = YES;
            _expiredDate = [NSDate dateWithTimeInterval:timeInterval sinceDate:self.beginDate];
        } else {
            _needCache = NO;
            _expiredDate = nil;
        }
    }
    return self;
}

MJExtensionCodingImplementation

@end
