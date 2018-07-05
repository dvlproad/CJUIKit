//
//  IjinbuSession.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/4/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuSession.h"

@implementation IjinbuSession

+ (instancetype)current {
    static IjinbuSession *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (BOOL)establish
{
    return self.user.token.length > 0;
}

- (void)invalidate
{
    self.nid = nil;
    self.uuid = nil;
    self.user = nil;
}


@end
