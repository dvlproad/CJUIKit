//
//  CJAppHaveLaunchUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAppHaveLaunchUtil : NSObject

+ (CJAppHaveLaunchUtil *)sharedInstance;

/**
 *  是否已经启动过（不区分用户，只要在这台手机上曾启动过计算）
 *
 *  reurn 是否已经启动过
 */
- (BOOL)isAPPHaveLaunch;

/**
 *  在启动一次之后将启动状态设为YES
 */
- (void)setAPPHaveLaunchStateYES;

@end
