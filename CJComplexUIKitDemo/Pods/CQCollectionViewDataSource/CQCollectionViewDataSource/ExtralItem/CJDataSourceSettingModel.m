//
//  CJDataSourceSettingModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDataSourceSettingModel.h"

@implementation CJDataSourceSettingModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _extralItemSetting = CJExtralItemSettingNone;
        _maxDataModelShowCount = NSIntegerMax;
    }
    return self;
}

@end
