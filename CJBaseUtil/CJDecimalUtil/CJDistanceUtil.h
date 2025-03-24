//
//  CJDistanceUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  距离相关的处理

#import <Foundation/Foundation.h>
#import "CJDecimalUtil.h"

@interface CJDistanceUtil : NSObject

#pragma mark - "米" 转 "公里"
///将米以保留1位小数的方式转为公里
+ (NSString *)oneUpDecimalKMStringFromMiles:(NSInteger)miles;

@end
