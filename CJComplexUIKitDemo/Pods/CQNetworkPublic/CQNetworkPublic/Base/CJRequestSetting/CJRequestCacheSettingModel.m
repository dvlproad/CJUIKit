//
//  CJRequestCacheSettingModel.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2018/5/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJRequestCacheSettingModel.h"

@implementation CJRequestCacheSettingModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cacheStrategy = CJRequestCacheStrategyNoneCache;
    }
    return self;
}


@end
