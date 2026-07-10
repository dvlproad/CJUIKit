//
//  CJCacheDataModel.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/3/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJCacheDataModel.h"
//#import <MJExtension/MJExtension.h>

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

//MJExtensionCodingImplementation
// 手动实现 NSCoding 协议方法

// 用于编码对象
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.dataObject forKey:@"dataObject"];
    [coder encodeObject:self.beginDate forKey:@"beginDate"];
    [coder encodeBool:self.needCache forKey:@"needCache"];
    [coder encodeObject:self.expiredDate forKey:@"expiredDate"];
}

// 用于解码对象
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _dataObject = [coder decodeObjectForKey:@"dataObject"];
        _beginDate = [coder decodeObjectForKey:@"beginDate"];
        _needCache = [coder decodeBoolForKey:@"needCache"];
        _expiredDate = [coder decodeObjectForKey:@"expiredDate"];
    }
    return self;
}

@end
