//
//  NormalSharedInstanceClass.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "NormalSharedInstanceClass.h"

@implementation NormalSharedInstanceClass

+ (NormalSharedInstanceClass *)sharedInstance {
    static NormalSharedInstanceClass *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end
