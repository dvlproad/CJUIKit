//
//  CJLogModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJLogModel.h"

@implementation CJLogModel

+ (instancetype)logWithString:(NSString *)logString {
    CJLogModel *log = [CJLogModel new];
    log.timestamp = [[NSDate date] timeIntervalSince1970];
    log.logString = logString;
    return log;
}

@end
