//
//  CJThemeManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJThemeManager.h"

@implementation CJThemeManager

+ (CJThemeManager *)sharedInstance {
    static CJThemeManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _serviceThemeModel = [[CJThemeModel alloc] init];
    }
    return self;
}

/**
 *  获取当前正在使用的主题
 *
 *  @return serviceThemeModel
 */
+ (CJThemeModel *)serviceThemeModel {
    return [CJThemeManager sharedInstance].serviceThemeModel;
}

@end
