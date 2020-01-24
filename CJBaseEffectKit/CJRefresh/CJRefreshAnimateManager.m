//
//  CJRefreshAnimateManager.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJRefreshAnimateManager.h"

@interface CJRefreshAnimateManager() {
    
}

@end

@implementation CJRefreshAnimateManager

+ (CJRefreshAnimateManager *)sharedInstance {
    static CJRefreshAnimateManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end
