//
//  PerfectSharedInstanceClass.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "PerfectSharedInstanceClass.h"

@implementation PerfectSharedInstanceClass

+ (PerfectSharedInstanceClass *)sharedInstance {
    static PerfectSharedInstanceClass *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //_sharedInstance = [[self alloc] init];
        _sharedInstance = [[super allocWithZone:NULL] init];
    });
    return _sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[self class] sharedInstance];
}

@end
